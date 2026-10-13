codeunit 50143 "Security Utils"
{
    Access = Internal;

    var
        HashAlgorithm: Option MD5,SHA1,SHA256,SHA384,SHA512;
        CryptoMgmt: Codeunit "Cryptography Management";

    procedure GenerateHash(Input: Text): Text
    begin
        HashAlgorithm := HashAlgorithm::SHA256;
        exit(CryptoMgmt.GenerateHash(Input, HashAlgorithm));
    end;

    // Hash a password with a new or provided salt
    procedure HashPassword(PlainTextPassword: Text; Salt: Text): Text
    var
        HashAlgorithmOption: Option MD5,SHA1,SHA256,SHA384,SHA512;
        GeneratedSalt: Text;
    begin
        if Salt = '' then
            GeneratedSalt := Format(CreateGuid())
        else
            GeneratedSalt := Salt;

        // Use SHA-256 for password hashing
        HashAlgorithmOption := 2; // SHA256 = 2
        exit(CryptoMgmt.GenerateHash(PlainTextPassword + GeneratedSalt, HashAlgorithmOption) + '::' + GeneratedSalt);
    end;

    // Generate a new random salt
    procedure GenerateSalt(): Text
    begin
        exit(Format(CreateGuid()));
    end;

    // Verify a password against a stored hash
    procedure VerifyPasswordHash(PlainTextPassword: Text; StoredHash: Text): Boolean
    var
        HashAlgorithmOption: Option MD5,SHA1,SHA256,SHA384,SHA512;
        CurrentHash: Text;
        ExtractedSalt: Text;
    begin
        // First check if it's a plaintext password (for backward compatibility)
        if PlainTextPassword = StoredHash then
            exit(true);

        // Check if the password contains salt information (new format with ::)
        if StrPos(StoredHash, '::') > 0 then begin
            // Split the hash and salt
            CurrentHash := CopyStr(StoredHash, 1, StrPos(StoredHash, '::') - 1);
            ExtractedSalt := CopyStr(StoredHash, StrPos(StoredHash, '::') + 2);

            // Generate hash with the extracted salt
            HashAlgorithmOption := 2; // SHA256 = 2
            exit(CryptoMgmt.GenerateHash(PlainTextPassword + ExtractedSalt, HashAlgorithmOption) = CurrentHash);
        end;

        // Default: plaintext comparison as fallback
        exit(PlainTextPassword = StoredHash);
    end;

    // Generate a random OTP
    procedure GenerateRandomOTP() OTP: Text[6]
    var
        i: Integer;
        RandomNum: Integer;
    begin
        OTP := '';
        for i := 1 to 6 do begin
            RandomNum := Random(10);
            OTP += Format(RandomNum);
        end;
    end;

    procedure ValidateRequestHash(RequestJson: JsonObject): Boolean
    var
        RequestToken: JsonToken;
        RequestHashToken: JsonToken;
        APIKey: Text;
        CalculatedHash: Text;
        RequestHash: Text;
    begin
        // Get the API key from the request
        if not RequestJson.SelectToken('$.request.api_key', RequestToken) then
            exit(false);

        APIKey := RequestToken.AsValue().AsText();

        // Get the hash from the request
        if not RequestJson.SelectToken('$.request.hash', RequestHashToken) then
            exit(false);

        RequestHash := RequestHashToken.AsValue().AsText();

        // Calculate the hash using the payload and timestamp
        CalculatedHash := CalculateRequestHash(RequestJson, APIKey);

        // Compare the hashes
        exit(CalculatedHash = RequestHash);
    end;

    local procedure CalculateRequestHash(RequestJson: JsonObject; APIKey: Text): Text
    var
        PayloadToken: JsonToken;
        TimestampToken: JsonToken;
        Payload: Text;
        Timestamp: Text;
        StringToHash: Text;
    begin
        // Get payload and timestamp from the request
        if not RequestJson.SelectToken('$.request.payload', PayloadToken) then
            exit('');

        if not RequestJson.SelectToken('$.request.timestamp', TimestampToken) then
            exit('');

        // Convert to text for hashing
        Payload := Format(PayloadToken);
        Timestamp := TimestampToken.AsValue().AsText();

        // Combine with API key for hashing
        StringToHash := Payload + Timestamp + APIKey;

        // Generate the hash
        exit(GenerateHash(StringToHash));
    end;

    // Log security events
    procedure LogSecurityEvent(EventType: Text; Username: Text; EventDetails: Text; IsAlert: Boolean)
    var
        SecurityLog: Record "Security Log";
        IPAddress: Text;
    begin
        SecurityLog.Init();
        SecurityLog."Event Type" := EventType;
        SecurityLog."User ID" := Username;
        SecurityLog."Date and Time" := CurrentDateTime;
        SecurityLog."Details" := EventDetails;
        SecurityLog."Is Alert" := IsAlert;

        // Try to get client IP if available - placeholder
        IPAddress := 'Unknown';
        SecurityLog."IP Address" := IPAddress;

        SecurityLog.Insert(true);

        // For critical security events, also log a telemetry event
        if IsAlert or
           (EventType = 'LoginFailure') or
           (EventType = 'AccountLocked') or
           (EventType = 'PasswordReset') or
           (EventType = 'SuspiciousActivity') then
            LogMessage('SecurityAlert', EventDetails, Verbosity::Warning,
                      DataClassification::EndUserPseudonymousIdentifiers,
                      TelemetryScope::ExtensionPublisher, 'Username', Username);
    end;

    // Check rate limiting for various actions
    procedure EnforceRateLimit(Username: Text; ActionType: Text): Boolean
    var
        SecurityLog: Record "Security Log";
        LastMinuteCount: Integer;
        LastHourCount: Integer;
        RateLimitExceeded: Boolean;
        OneMinuteAgo: DateTime;
        OneHourAgo: DateTime;
    begin
        OneMinuteAgo := CurrentDateTime - (60 * 1000); // 1 minute ago in milliseconds
        OneHourAgo := CurrentDateTime - (60 * 60 * 1000); // 1 hour ago in milliseconds

        // Count events in the last minute
        SecurityLog.Reset();
        SecurityLog.SetRange("User ID", Username);
        SecurityLog.SetRange("Event Type", ActionType);
        SecurityLog.SetFilter("Date and Time", '>%1', OneMinuteAgo);
        LastMinuteCount := SecurityLog.Count;

        // Count events in the last hour
        SecurityLog.Reset();
        SecurityLog.SetRange("User ID", Username);
        SecurityLog.SetRange("Event Type", ActionType);
        SecurityLog.SetFilter("Date and Time", '>%1', OneHourAgo);
        LastHourCount := SecurityLog.Count;

        // Apply rate limits based on action type
        RateLimitExceeded := false;

        case ActionType of
            'LoginAttempt':
                RateLimitExceeded := (LastMinuteCount >= 5) or (LastHourCount >= 20);
            'OTPGeneration':
                RateLimitExceeded := (LastMinuteCount >= 3) or (LastHourCount >= 10);
            'PasswordReset':
                RateLimitExceeded := (LastMinuteCount >= 2) or (LastHourCount >= 5);
            'ApiRequest':
                RateLimitExceeded := (LastMinuteCount >= 30) or (LastHourCount >= 300);
            else
                RateLimitExceeded := false;
        end;

        // Log if rate limit exceeded
        if RateLimitExceeded then
            LogSecurityEvent('RateLimitExceeded', Username,
                            StrSubstNo('Rate limit exceeded for %1: %2/min, %3/hour',
                                      ActionType, LastMinuteCount, LastHourCount), true);

        exit(not RateLimitExceeded);
    end;

    // Validate password complexity
    procedure ValidatePasswordComplexity(Password: Text) validPassword: Boolean
    var
        HasLength: Boolean;
        HasUpperCase: Boolean;
        HasLowerCase: Boolean;
        HasDigit: Boolean;
        HasSpecial: Boolean;
        i: Integer;
        c: Char;
    begin
        HasLength := StrLen(Password) >= 8;
        HasUpperCase := false;
        HasLowerCase := false;
        HasDigit := false;
        HasSpecial := false;

        for i := 1 to StrLen(Password) do begin
            c := Password[i];

            if (c >= 'A') and (c <= 'Z') then
                HasUpperCase := true
            else if (c >= 'a') and (c <= 'z') then
                HasLowerCase := true
            else if (c >= '0') and (c <= '9') then
                HasDigit := true
            else
                HasSpecial := true;
        end;
        validPassword := false;

        if HasLength then
            if HasUpperCase then
                if HasLowerCase then
                    if HasDigit then
                        if HasSpecial then
                            validPassword := true;


        // Require at least 3 of the 5 complexity rules
        exit(validPassword);
    end;
}
