Codeunit 50121 MZawadi
{
    // Newtonsoft.Json.JsonTextWriter.'Newtonsoft.Json, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed'


    trigger OnRun()
    var
        j: Integer;

    begin



        Members.RESET;
        Members.SetFilter("Mobile Phone No.", '<>%1', '');
        Members.setfilter("Employer Code", '%1|%2', '001', '003');
        IF Members.FINDFIRST THEN BEGIN
            MzawadiRegistrations.DeleteAll();
            MzawadiRewards.DeleteAll();
            REPEAT
                IF NOT MzawadiRegistrations.GET(Members."No.") THEN BEGIN
                    j += 1;
                    MzawadiRegistrations.INIT;
                    MzawadiRegistrations."Member No." := Members."No.";
                    MzawadiRegistrations.Name := Members.Name;
                    MzawadiRegistrations."Phone No." := Members."Mobile Phone No.";
                    MzawadiRegistrations.INSERT;
                END;
            UNTIL (Members.NEXT = 0) OR (j > 30);
        END;



        MzawadiRegistrations.RESET;
        IF MzawadiRegistrations.FINDFIRST THEN BEGIN
            j := 0;
            REPEAT
                j += 1;
                MzawadiRewards.INIT;
                MzawadiRewards.GUID := FORMAT(CREATEGUID);
                MzawadiRewards."Member No." := MzawadiRegistrations."Member No.";
                MzawadiRewards.Name := MzawadiRegistrations.Name;
                MzawadiRewards.Date := TODAY;
                MzawadiRewards.Time := TIME;
                IF j = RANDOM(8) THEN
                    MzawadiRewards.Command := MZ_alternative_channels
                ELSE
                    IF j = RANDOM(8) THEN
                        MzawadiRewards.Command := MZ_change_paypoint
                    ELSE
                        IF j = RANDOM(8) THEN
                            MzawadiRewards.Command := MZ_subaccount
                        ELSE
                            IF j = RANDOM(8) THEN
                                MzawadiRewards.Command := MZ_referral
                            ELSE
                                IF j = RANDOM(8) THEN
                                    MzawadiRewards.Command := MZ_recruitment
                                ELSE
                                    IF j = RANDOM(8) THEN
                                        MzawadiRewards.Command := MZ_upward_contributions
                                    ELSE
                                        IF j = RANDOM(8) THEN
                                            MzawadiRewards.Command := MZ_upward_shares
                                        ELSE
                                            MzawadiRewards.Command := MZ_alternative_channels;



                if J > 8 then
                    j := 1;
                MzawadiRewards.INSERT;
            UNTIL MzawadiRegistrations.NEXT = 0;
        END;





        //Message(GetClientsToEnroll);
        //MESSAGE(GetRewardsToInitiate);

    end;


    procedure GetClientsToEnroll() Response: Text
    var

        LocalStringWriter: Text;
        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
        Indent: Boolean;
        "Action": Code[50];
        PicBase64: Text;
        Found: Boolean;
        MzawadiRegistrations: Record "Mzawadi Registrations";
        JsonAcc: JsonObject;
        JsonAccArray: JsonArray;
    begin



        MzawadiRegistrations.Reset;
        MzawadiRegistrations.SetRange(Registered, false);
        if MzawadiRegistrations.FindSet() then begin
            repeat
                Clear(JsonAcc);
                JsonAcc.Add('client_name', MzawadiRegistrations.Name);
                JsonAcc.Add('client_code', MzawadiRegistrations."Member No.");
                JsonAcc.Add('client_phone', MzawadiRegistrations."Phone No.");

                JsonAccArray.Add(JsonAcc);

            until MzawadiRegistrations.Next = 0;

            JsonResult.Add('clients', JsonAccArray);
            JsonResult.WriteTo(Response);
        end;
    end;


    procedure UpdateClientsAfterEnroll(MemberNo: Code[20]; ClientPhone: Text; Status: Text) Response: Text
    var

        LocalStringWriter: Text;
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
        Indent: Boolean;
        "Action": Code[50];
        PicBase64: Text;
        Found: Boolean;
        MzawadiRegistrations: Record "Mzawadi Registrations";
    begin


        Response := 'FAILED';


        // if Status = 'SUCCESS' then begin
        MzawadiRegistrations.Reset;
        MzawadiRegistrations.SetRange("Member No.", MemberNo);
        MzawadiRegistrations.SetRange("Phone No.", ClientPhone);
        if MzawadiRegistrations.FindFirst then begin
            MzawadiRegistrations.Registered := true;
            MzawadiRegistrations.Modify;

            Response := 'SUCCESS';
        end;
    end;


    // end;


    procedure GetRewardsToInitiate() Response: Text
    var

        LocalStringWriter: Text;
        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
        Indent: Boolean;
        "Action": Code[50];
        PicBase64: Text;
        Found: Boolean;
        MzawadiRewards: Record "Mzawadi Rewards";
        JsonReward: JsonObject;
        JsonRewardArray: JsonArray;
    begin

        MzawadiRewards.Reset;
        MzawadiRewards.SetRange(Rewarded, false);
        MzawadiRewards.SetRange(initiated, false);
        if MzawadiRewards.FindFirst() then begin
            repeat
                Clear(JsonReward);
                JsonReward.Add('id', MzawadiRewards.Guid);
                JsonReward.Add('client_code', MzawadiRewards."Member No.");
                JsonReward.Add('command_id', MzawadiRewards.Command);
                JsonRewardArray.Add(JsonReward);

                MzawadiRewards.initiated := true;
                MzawadiRewards.Modify();
            until MzawadiRewards.Next = 0;

            JsonResult.Add('rewards', JsonRewardArray);
            JsonResult.WriteTo(Response);
        end;


    end;


    procedure UpdateRewardsAfterInitiation(id: Text; clientCode: Code[20]; CommandId: Text; Status: Text) Response: Text
    var

        LocalStringWriter: Text;
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
        Indent: Boolean;
        "Action": Code[50];
        PicBase64: Text;
        Found: Boolean;
        MzawadiRewards: Record "Mzawadi Rewards";
    begin

        Response := 'FAILED';

        //if Status = 'SUCCESS' then begin
        MzawadiRewards.Reset;
        MzawadiRewards.SetRange(Guid, id);
        MzawadiRewards.SetRange("Member No.", ClientCode);
        MzawadiRewards.SetRange(Command, CommandId);
        if MzawadiRewards.FindFirst then begin
            MzawadiRewards.Rewarded := true;
            MzawadiRewards.Modify;
        end;
        //end;

        Response := 'SUCCESS';
    end;




    procedure RewardMember(MemberNo: Code[20]; Command: Text) Success: Boolean;
    begin

        Success := false;
        Members.RESET;
        Members.setrange("Member No.", MemberNo);
        IF Members.FINDFIRST THEN BEGIN
            IF NOT MzawadiRegistrations.GET(Members."No.") THEN BEGIN
                MzawadiRegistrations.INIT;
                MzawadiRegistrations."Member No." := Members."No.";
                MzawadiRegistrations.Name := Members.Name;
                MzawadiRegistrations."Phone No." := Members."Mobile Phone No.";
                MzawadiRegistrations.INSERT;
            END;
        END;



        IF MzawadiRegistrations.get(MemberNo) THEN BEGIN

            MzawadiRewards.INIT;
            MzawadiRewards.GUID := FORMAT(CREATEGUID);
            MzawadiRewards."Member No." := MzawadiRegistrations."Member No.";
            MzawadiRewards.Name := MzawadiRegistrations.Name;
            MzawadiRewards.Date := TODAY;
            MzawadiRewards.Time := TIME;
            MzawadiRewards.Command := Command;
            MzawadiRewards."Created By" := UserId;
            MzawadiRewards."Date Created" := today;
            if MzawadiRewards.INSERT then
                Success := true;
        END;

    end;

    procedure RewardReferal()
    var
        Legacy: Codeunit Legacy;
        MActivities: Codeunit "Member Activities";
        AccNo: Code[20];
        Bal: Decimal;
        Cust: Record Members;
    begin


        Members.RESET;
        Members.setfilter("Registration Date", '>=%1', DMY2Date(01, 07, 2023));
        Members.SetRange(Rewarded, false);
        IF Members.FINDFIRST THEN BEGIN
            repeat
                if Cust.get(Members."Recruited By") then begin

                    AccNo := Legacy.GetRegFeeAccount(Members."No.");
                    Bal := MActivities.GetAccountBalance(AccNo);
                    if Bal > 500 then begin

                        AccNo := Legacy.GetDepositAccounts(Members."No.");
                        Bal := MActivities.GetAccountBalance(AccNo);
                        if Bal > 1000 then begin

                            AccNo := Legacy.GetShareCapitalAccount(Members."No.");
                            Bal := MActivities.GetAccountBalance(AccNo);
                            if Bal > 1000 then begin
                                if RewardMember(Cust."No.", MZ_referral) then begin
                                    Members.Rewarded := true;
                                    Members.Modify();
                                end;
                            end
                        end
                    end;

                end;
            until Members.Next() = 0;
        END;
    end;



    var
        JObject: JsonObject;
        MActivities: Codeunit "Member Activities";
        SActivities: Codeunit "Sacco Activities";
        JsObject_1: JsonObject;
        JsObject_2: JsonObject;
        JsObject_3: JsonObject;
        JsObject_4: JsonObject;
        JsObject_5: JsonObject;
        JsObject_6: JsonObject;
        JsonResult: JsonObject;
        JsonEmptyArray: JsonArray;
        JSON_Array: JsonArray;
        JsArray1: JsonArray;
        JsArray2: JsonArray;
        JsArray3: JsonArray;
        JsArray4: JsonArray;
        JsArray5: JsonArray;

        Sep: label '\::/';
        Null: label 'NULL';
        Success: label '200';
        Account_Does_Not_Exist: label '300';
        Parameters_Not_Valid_Or_Missing: label '400';
        Caller_Not_Authorized_For_This_Request: label '401';
        Insufficient_Funds: label '402';
        Daily_Amount_Limit_Reached: label '403';
        Operation_Does_Not_Exist: label '404';
        Daily_Frequency_Limit_Reached: label '405';
        Severe_problem_Has_Occured: label '500';
        EndRec: label '\::::/';
        JSonString: Text;
        ArrayString: Text;
        ArrayString1: Text;

        StringWriter: Text;
        GlobalNULL: Variant;
        Members: Record Members;
        MzawadiRegistrations: Record "Mzawadi Registrations";
        MzawadiRewards: Record "Mzawadi Rewards";
        MZ_alternative_channels: label 'alternative_channels';
        MZ_upward_contributions: label 'upward_contributions';
        MZ_upward_shares: label 'upward_shares';
        MZ_change_paypoint: label 'change_paypoint';
        MZ_subaccount: label 'subaccount';
        MZ_referral: label 'Referral';
        MZ_recruitment: label 'Recruitment';







}

