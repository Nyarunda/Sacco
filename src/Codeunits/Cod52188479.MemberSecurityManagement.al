codeunit 50142 "Member Security Management"
{
    // This codeunit contains methods to manage member security questions and answers

    /// <summary>
    /// Sets up security questions for a member
    /// </summary>
    /// <param name="MemberNo">Member number</param>
    /// <param name="QuestionID">Question ID from Portal Mbanking Questions</param>
    /// <param name="Answer">Answer to the security question</param>
    /// <returns>True if successful, false otherwise</returns>
    procedure SetupSecurityQuestion(MemberNo: Code[20]; QuestionID: Integer; Answer: Text): Boolean
    var
        MemberSecurityQuestions: Record "Member Security Questions";
        SecurityUtils: Codeunit "Security Utils";
    begin
        // Check if this question is already set for the member
        MemberSecurityQuestions.Reset();
        MemberSecurityQuestions.SetRange("Member No", MemberNo);
        MemberSecurityQuestions.SetRange("Question ID", QuestionID);
        if MemberSecurityQuestions.FindFirst() then begin
            // Update existing question
            MemberSecurityQuestions."Answer" := SecurityUtils.GenerateHash(Answer);
            MemberSecurityQuestions."Is Active" := true;
            exit(MemberSecurityQuestions.Modify());
        end else begin
            // Create new question
            MemberSecurityQuestions.Init();
            MemberSecurityQuestions.Validate("Member No", MemberNo);
            MemberSecurityQuestions.Validate("Question ID", QuestionID);
            MemberSecurityQuestions.Validate("Answer", SecurityUtils.GenerateHash(Answer));
            MemberSecurityQuestions.Validate("Is Active", true);
            exit(MemberSecurityQuestions.Insert());
        end;
    end;

    /// <summary>
    /// Validates member's answer to a security question
    /// </summary>
    /// <param name="MemberNo">Member number</param>
    /// <param name="QuestionID">Question ID from Portal Mbanking Questions</param>
    /// <param name="Answer">Answer provided by member to validate</param>
    /// <returns>True if answer is correct, false otherwise</returns>
    procedure ValidateSecurityQuestion(MemberNo: Code[20]; QuestionID: Integer; Answer: Text): Boolean
    var
        MemberSecurityQuestions: Record "Member Security Questions";
        SecurityUtils: Codeunit "Security Utils";
        HashedAnswer: Text;
    begin
        HashedAnswer := SecurityUtils.GenerateHash(Answer);

        MemberSecurityQuestions.Reset();
        MemberSecurityQuestions.SetRange("Member No", MemberNo);
        MemberSecurityQuestions.SetRange("Question ID", QuestionID);
        MemberSecurityQuestions.SetRange("Is Active", true);
        if MemberSecurityQuestions.FindFirst() then
            exit(MemberSecurityQuestions."Answer" = HashedAnswer);

        exit(false);
    end;

    /// <summary>
    /// Gets a list of active security questions for a member
    /// </summary>
    /// <param name="MemberNo">Member number</param>
    /// <param name="QuestionIDList">List of question IDs (output)</param>
    procedure GetMemberSecurityQuestions(MemberNo: Code[20]; var QuestionIDList: List of [Integer])
    var
        MemberSecurityQuestions: Record "Member Security Questions";
    begin
        Clear(QuestionIDList);

        MemberSecurityQuestions.Reset();
        MemberSecurityQuestions.SetRange("Member No", MemberNo);
        MemberSecurityQuestions.SetRange("Is Active", true);

        if MemberSecurityQuestions.FindSet() then begin
            repeat
                QuestionIDList.Add(MemberSecurityQuestions."Question ID");
            until MemberSecurityQuestions.Next() = 0;
        end;
    end;

    /// <summary>
    /// Checks if a member has set up the required minimum number of security questions
    /// </summary>
    /// <param name="MemberNo">Member number</param>
    /// <param name="MinQuestions">Minimum required number of questions</param>
    /// <returns>True if member has set up the minimum required questions, false otherwise</returns>
    procedure HasMinimumSecurityQuestions(MemberNo: Code[20]; MinQuestions: Integer): Boolean
    var
        MemberSecurityQuestions: Record "Member Security Questions";
        QuestionCount: Integer;
    begin
        MemberSecurityQuestions.Reset();
        MemberSecurityQuestions.SetRange("Member No", MemberNo);
        MemberSecurityQuestions.SetRange("Is Active", true);
        QuestionCount := MemberSecurityQuestions.Count;

        exit(QuestionCount >= MinQuestions);
    end;

    /// <summary>
    /// Gets a random security question for a member
    /// </summary>
    /// <param name="MemberNo">Member number</param>
    /// <param name="QuestionID">Question ID (output)</param>
    /// <param name="QuestionText">Question text (output)</param>
    /// <returns>True if a question was found, false otherwise</returns>
    procedure GetRandomSecurityQuestion(MemberNo: Code[20]; var QuestionID: Integer; var QuestionText: Text): Boolean
    var
        MemberSecurityQuestions: Record "Member Security Questions";
        PortalQuestions: Record "Portal Mbanking Questions";
        QuestionList: List of [Integer];
        RandomIndex: Integer;
        RecCount: Integer;
    begin
        QuestionID := 0;
        QuestionText := '';

        GetMemberSecurityQuestions(MemberNo, QuestionList);
        RecCount := QuestionList.Count();

        if RecCount = 0 then
            exit(false);

        // Get a random question
        RandomIndex := Random(RecCount) + 1;
        QuestionID := QuestionList.Get(RandomIndex);

        // Get the question text
        if PortalQuestions.Get(QuestionID) then begin
            QuestionText := PortalQuestions.Questions;
            exit(true);
        end;

        exit(false);
    end;
}
