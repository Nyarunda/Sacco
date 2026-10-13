page 51202 "Bulk Email Header"
{
    ApplicationArea = All;
    Caption = 'Bulk Email Header';
    PageType = Card;
    SourceTable = "Bulk Email Header";
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No) { ApplicationArea = All; Editable = false; }
                field("Date Entered"; Rec."Date Entered") { ApplicationArea = All; Editable = false; }
                field("Time Entered"; Rec."Time Entered") { ApplicationArea = All; Editable = false; }
                field("Entered By"; Rec."Entered By") { ApplicationArea = All; Editable = false; }
                field("Email Status"; Rec."Email Status") { ApplicationArea = All; Editable = false; }
                field("Status Date"; Rec."Status Date") { ApplicationArea = All; Editable = false; }
                field("Status Time"; Rec."Status Time") { ApplicationArea = All; Editable = false; }
                field("Status By"; Rec."Status By") { ApplicationArea = All; Editable = false; }
                field(Entries; Rec.Entries) { ApplicationArea = All; Editable = false; }
                field(Attachments; Rec.Attachments) { ApplicationArea = All; Editable = false; }
            }

            group(Message)
            {
                field("Email Subject"; Rec."Email Subject") { ApplicationArea = All; }
                field("Email Body"; Rec."Email Body")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Supports placeholders such as [First Name], [Member Name], [Member No.], [Email], [Mobile No.], [Savings Account No.], [Product Name], [Child Name], [Junior Name], [Loan No.], [Loan Details], [Loan Product], [Installments], and [Monthly Repayment].';
                }
                field("Endpoint URL"; Rec."Endpoint URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Optional encryption API endpoint. Leave blank to use the default endpoint when attachments are enabled.';
                }
                field("Source File Path"; Rec."Source File Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'Optional PDF URL/path. Prefer using the attachment lines for uploaded files.';
                }
            }

            group(Targeting)
            {
                field("Email Type"; Rec."Email Type") { ApplicationArea = All; }
                field("Filter Type"; Rec."Filter Type")
                {
                    ApplicationArea = All;
                    Visible = Rec."Email Type" = Rec."Email Type"::Everyone;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = (Rec."Email Type" = Rec."Email Type"::Branch) or (Rec."Email Type" = Rec."Email Type"::"Branch & Product");
                }
                field(Product; Rec.Product)
                {
                    ApplicationArea = All;
                    Visible = (Rec."Email Type" = Rec."Email Type"::Product) or (Rec."Email Type" = Rec."Email Type"::"Branch & Product");
                }
                field("Product Balance Filter"; Rec."Product Balance Filter")
                {
                    ApplicationArea = All;
                    Visible = Rec."Email Type" = Rec."Email Type"::Product;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = All;
                    Visible = Rec."Email Type" = Rec."Email Type"::Employer;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    Visible = Rec."Email Type" = Rec."Email Type"::Gender;
                }
                field(Religion; Rec.Religion)
                {
                    ApplicationArea = All;
                    Visible = Rec."Email Type" = Rec."Email Type"::Religion;
                }
                field("Member Status"; Rec."Member Status")
                {
                    ApplicationArea = All;
                    Visible = Rec."Email Type" = Rec."Email Type"::Status;
                }
                field("Active Members Only"; Rec."Active Members Only") { ApplicationArea = All; }
                field("Member Category"; Rec."Member Category") { ApplicationArea = All; }
            }

            part(Lines; "Bulk Email Lines Part")
            {
                ApplicationArea = All;
                SubPageLink = No = field(No);
            }
            part(AttachmentLines; "Bulk Email Attachments Part")
            {
                ApplicationArea = All;
                SubPageLink = No = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(GenerateRecipients)
            {
                ApplicationArea = All;
                Caption = 'Generate Recipients';
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    GenerateEmailLines();
                end;
            }
            action(SendEmails)
            {
                ApplicationArea = All;
                Caption = 'Send Emails';
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Email Subject");
                    if not ((Rec."Email Type" = Rec."Email Type"::Everyone) and
                            (Rec."Filter Type" = Rec."Filter Type"::JuniorAccount)) then
                        Rec.TestField("Email Body");
                    if not Confirm('Send emails to %1 recipient(s)?', false, Rec.Entries) then
                        exit;

                    UpdateEmailLineBodies();
                    Rec.SendEmails();
                    CurrPage.Update(false);
                end;
            }
        }
    }

    local procedure GenerateEmailLines()
    var
        ExistingLine: Record "Bulk Email Lines";
        Member: Record Members;
        SavingsAccount: Record "Savings Accounts";
        Window: Dialog;
        TotalRecords: Integer;
        CurrentRecordNo: Integer;
        GeneratedCount: Integer;
    begin
        if Rec."Email Status" <> Rec."Email Status"::Pending then
            Error('This bulk email has already been processed.');

        ExistingLine.Reset();
        ExistingLine.SetRange(No, Rec.No);
        if not ExistingLine.IsEmpty() then
            if not Confirm('There are %1 existing email line(s). Do you want to delete and regenerate?', false, ExistingLine.Count()) then
                exit
            else
                ExistingLine.DeleteAll();

        if (Rec."Filter Type" <> Rec."Filter Type"::None) and (Rec."Email Type" = Rec."Email Type"::Everyone) then begin
            if Rec."Filter Type" = Rec."Filter Type"::MemberWithLoanBalance then begin
                GenerateByLoanFilter(GeneratedCount);
                Message('Completed. Generated %1 recipient(s).', GeneratedCount);
                exit;
            end;

            GenerateByAdvancedFilter(GeneratedCount);
            Message('Completed. Generated %1 recipient(s).', GeneratedCount);
            exit;
        end;

        if Rec."Email Type" in [Rec."Email Type"::Product, Rec."Email Type"::"Branch & Product"] then begin
            Rec.TestField(Product);
            if Rec."Email Type" = Rec."Email Type"::"Branch & Product" then
                Rec.TestField("Global Dimension 2 Code");

            SavingsAccount.Reset();
            if Rec."Active Members Only" then
                SavingsAccount.SetRange(Status, SavingsAccount.Status::Active);
            SavingsAccount.SetRange("Product Type", Rec.Product);
            if Rec."Email Type" = Rec."Email Type"::"Branch & Product" then
                SavingsAccount.SetRange("Global Dimension 2 Code", Rec."Global Dimension 2 Code");
            if Rec."Product Balance Filter" <> '' then
                SavingsAccount.SetFilter("Balance (LCY)", Rec."Product Balance Filter");

            TotalRecords := SavingsAccount.Count();
            if TotalRecords = 0 then
                exit;

            Window.Open('Generating recipients...\' +
                        'Counter #1#######\' +
                        'Total   #2#######\' +
                        'Created #3#######');
            if SavingsAccount.FindSet() then
                repeat
                    CurrentRecordNo += 1;
                    if Member.Get(SavingsAccount."Member No.") and MemberMatchesCategory(Member) then
                        if TryInsertEmailLineForSavings(Member, SavingsAccount) then
                            GeneratedCount += 1;
                    Window.Update(1, CurrentRecordNo);
                    Window.Update(2, TotalRecords);
                    Window.Update(3, GeneratedCount);
                until SavingsAccount.Next() = 0;
            Window.Close();
        end else begin
            Member.Reset();
            ApplyBasicMemberFilters(Member);
            Member.SetFilter("E-Mail", '<>%1', '');
            TotalRecords := Member.Count();
            if TotalRecords = 0 then
                exit;

            Window.Open('Generating recipients...\' +
                        'Counter #1#######\' +
                        'Total   #2#######\' +
                        'Created #3#######');
            if Member.FindSet() then
                repeat
                    CurrentRecordNo += 1;
                    if TryInsertEmailLine(Member, false) then
                        GeneratedCount += 1;
                    Window.Update(1, CurrentRecordNo);
                    Window.Update(2, TotalRecords);
                    Window.Update(3, GeneratedCount);
                until Member.Next() = 0;
            Window.Close();
        end;

        Message('Completed. Generated %1 recipient(s).', GeneratedCount);
    end;

    local procedure ApplyBasicMemberFilters(var Member: Record Members)
    begin
        if Rec."Active Members Only" then
            Member.SetRange("Member Status", Member."Member Status"::Active);

        case Rec."Email Type" of
            Rec."Email Type"::Branch:
                begin
                    Rec.TestField("Global Dimension 2 Code");
                    Member.SetRange("Global Dimension 2 Code", Rec."Global Dimension 2 Code");
                end;
            Rec."Email Type"::Employer:
                begin
                    Rec.TestField("Employer Code");
                    Member.SetRange("Employer Code", Rec."Employer Code");
                end;
            Rec."Email Type"::Gender:
                begin
                    Rec.TestField(Gender);
                    Member.SetRange(Gender, Rec.Gender);
                end;
            Rec."Email Type"::Religion:
                begin
                    Rec.TestField(Religion);
                    Member.SetRange(Religion, Rec.Religion);
                end;
            Rec."Email Type"::Status:
                begin
                    Rec.TestField("Member Status");
                    if Rec."Member Status" in [Rec."Member Status"::Deceased, Rec."Member Status"::Withdrawn] then
                        Error('Bulk email recipients cannot be generated for Deceased or Withdrawn members.');
                    Member.SetRange("Member Status", Rec."Member Status");
                end;
        end;

        ExcludeDeceasedAndWithdrawnMembers(Member);

        ApplyMemberCategoryFilter(Member);
    end;

    local procedure ExcludeDeceasedAndWithdrawnMembers(var Member: Record Members)
    begin
        if Member.GetFilter("Member Status") = '' then
            Member.SetFilter(
                "Member Status",
                '<>%1&<>%2',
                Member."Member Status"::Deceased,
                Member."Member Status"::Withdrawn);
    end;

    local procedure GenerateByAdvancedFilter(var GeneratedCount: Integer)
    var
        Member: Record Members;
        Window: Dialog;
        TotalRecords: Integer;
        CurrentRecordNo: Integer;
    begin
        Member.Reset();
        ApplyAdvancedMemberStatusFilter(Member, Rec."Filter Type");
        ApplyMemberCategoryFilter(Member);
        Member.SetFilter("E-Mail", '<>%1', '');
        TotalRecords := Member.Count();
        if TotalRecords = 0 then
            exit;

        Window.Open('Generating recipients...\' +
                    'Counter #1#######\' +
                    'Total   #2#######\' +
                    'Created #3#######');

        if Member.FindSet() then
            repeat
                CurrentRecordNo += 1;
                if ShouldInsertLine(Member."No.", Rec."Filter Type") then
                    if IsSavingsFilter(Rec."Filter Type") then
                        GeneratedCount += InsertSavingsEmailLinesForFilter(Member, Rec."Filter Type")
                    else
                        if TryInsertEmailLine(Member, false) then
                            GeneratedCount += 1;
                Window.Update(1, CurrentRecordNo);
                Window.Update(2, TotalRecords);
                Window.Update(3, GeneratedCount);
            until Member.Next() = 0;

        Window.Close();
    end;

    local procedure ApplyMemberCategoryFilter(var Member: Record Members)
    begin
        if Rec."Member Category" <> Rec."Member Category"::" " then
            Member.SetRange("Member Category", Rec."Member Category");
    end;

    local procedure MemberMatchesCategory(Member: Record Members): Boolean
    begin
        if Rec."Member Category" = Rec."Member Category"::" " then
            exit(true);

        exit(Member."Member Category" = Rec."Member Category");
    end;

    local procedure GenerateByLoanFilter(var GeneratedCount: Integer)
    var
        Member: Record Members;
        Loans: Record Loans;
        Window: Dialog;
        TotalRecords: Integer;
        CurrentRecordNo: Integer;
    begin
        Loans.Reset();
        Loans.SetFilter("Total Outstanding Balance", '>0');
        TotalRecords := Loans.Count();
        if TotalRecords = 0 then
            exit;

        Window.Open('Generating loan recipients...\' +
                    'Counter #1#######\' +
                    'Total   #2#######\' +
                    'Created #3#######');

        if Loans.FindSet() then
            repeat
                CurrentRecordNo += 1;
                if Member.Get(Loans."Member No.") then
                    if MemberMatchesCategory(Member) then
                        if TryInsertEmailLineForLoans(Member) then
                            GeneratedCount += 1;
                Window.Update(1, CurrentRecordNo);
                Window.Update(2, TotalRecords);
                Window.Update(3, GeneratedCount);
            until Loans.Next() = 0;

        Window.Close();
    end;

    local procedure TryInsertEmailLine(Member: Record Members; AllowDuplicateEmail: Boolean): Boolean
    var
        BulkEmailLine: Record "Bulk Email Lines";
        ExistingLine: Record "Bulk Email Lines";
    begin
        if Member."E-Mail" = '' then
            exit(false);

        if not AllowDuplicateEmail then begin
            ExistingLine.Reset();
            ExistingLine.SetRange(No, Rec.No);
            ExistingLine.SetRange("E-Mail", Member."E-Mail");
            if ExistingLine.FindFirst() then
                exit(false);
        end;

        BulkEmailLine.Init();
        BulkEmailLine.No := Rec.No;
        BulkEmailLine.Validate("Member No.", Member."No.");
        if BulkEmailLine."E-Mail" = '' then
            BulkEmailLine."E-Mail" := Member."E-Mail";
        exit(BulkEmailLine.Insert(true));
    end;

    local procedure TryInsertEmailLineForSavings(Member: Record Members; SavingsAccount: Record "Savings Accounts"): Boolean
    var
        BulkEmailLine: Record "Bulk Email Lines";
    begin
        if not CreateEmailLine(Member, true, BulkEmailLine) then
            exit(false);

        SetOptionalLineField(BulkEmailLine, 'Savings Account No.', SavingsAccount."No.");
        SetOptionalLineField(BulkEmailLine, 'Savings Account No', SavingsAccount."No.");
        SetOptionalLineField(BulkEmailLine, 'Account No.', SavingsAccount."No.");
        SetOptionalLineField(BulkEmailLine, 'Account No', SavingsAccount."No.");
        SetOptionalLineField(BulkEmailLine, 'Product Name', SavingsAccount."Product Name");
        SetOptionalLineField(BulkEmailLine, 'Product Type', SavingsAccount."Product Type");
        SetOptionalLineField(BulkEmailLine, 'Product Category', Format(SavingsAccount."Product Category"));
        SetOptionalLineField(BulkEmailLine, 'Child Name', SavingsAccount."Child Name");
        SetOptionalLineField(BulkEmailLine, 'Source Details', StrSubstNo('%1 - %2', SavingsAccount."No.", SavingsAccount."Product Name"));
        SetOptionalLineField(BulkEmailLine, 'Email Body', BuildSavingsEmailBody(Member, SavingsAccount));
        SetOptionalLineField(BulkEmailLine, 'Body', BuildSavingsEmailBody(Member, SavingsAccount));
        SetOptionalLineField(BulkEmailLine, 'Message', BuildSavingsEmailBody(Member, SavingsAccount));

        exit(BulkEmailLine.Modify(true));
    end;

    local procedure TryInsertEmailLineForLoan(Member: Record Members; Loan: Record Loans): Boolean
    var
        BulkEmailLine: Record "Bulk Email Lines";
    begin
        if not CreateEmailLine(Member, true, BulkEmailLine) then
            exit(false);

        SetOptionalLineField(BulkEmailLine, 'Loan No.', Loan."Loan No.");
        SetOptionalLineField(BulkEmailLine, 'Loan No', Loan."Loan No.");
        SetOptionalLineField(BulkEmailLine, 'Loan Account No.', Loan."Loan Account");
        SetOptionalLineField(BulkEmailLine, 'Loan Account No', Loan."Loan Account");
        SetOptionalLineField(BulkEmailLine, 'Loan Product Type', Loan."Loan Product Type");
        SetOptionalLineField(BulkEmailLine, 'Loan Product Type Name', Loan."Loan Product Type Name");
        SetOptionalLineField(BulkEmailLine, 'Loan Product', Loan."Loan Product Type Name");
        SetOptionalLineField(BulkEmailLine, 'Installments', Format(Loan.Installments));
        SetOptionalLineField(BulkEmailLine, 'Monthly Installment', Format(Loan.Repayment));
        SetOptionalLineField(BulkEmailLine, 'Monthly Repayment', Format(Loan.Repayment));
        SetOptionalLineField(BulkEmailLine, 'Source Details', StrSubstNo('%1 - %2, Installments: %3, Monthly Repayment: %4',
            Loan."Loan No.", Loan."Loan Product Type Name", Loan.Installments, Loan.Repayment));
        SetOptionalLineField(BulkEmailLine, 'Email Body', BuildLoanEmailBody(Member, Loan));
        SetOptionalLineField(BulkEmailLine, 'Body', BuildLoanEmailBody(Member, Loan));
        SetOptionalLineField(BulkEmailLine, 'Message', BuildLoanEmailBody(Member, Loan));

        exit(BulkEmailLine.Modify(true));
    end;

    local procedure TryInsertEmailLineForLoans(Member: Record Members): Boolean
    var
        BulkEmailLine: Record "Bulk Email Lines";
        EmailBody: Text;
    begin
        if not CreateEmailLine(Member, false, BulkEmailLine) then
            exit(false);

        EmailBody := BuildLoansEmailBody(Member);
        SetOptionalLineField(BulkEmailLine, 'Email Body', EmailBody);
        SetOptionalLineField(BulkEmailLine, 'Body', EmailBody);
        SetOptionalLineField(BulkEmailLine, 'Message', EmailBody);

        exit(BulkEmailLine.Modify(true));
    end;

    local procedure BuildSavingsEmailBody(Member: Record Members; SavingsAccount: Record "Savings Accounts"): Text
    var
        EmailBody: Text;
    begin
        EmailBody := Rec."Email Body";
        ReplaceMemberPlaceholders(EmailBody, Member);
        EmailBody := EmailBody.Replace('[Savings Account No.]', SavingsAccount."No.");
        EmailBody := EmailBody.Replace('[Savings Account No]', SavingsAccount."No.");
        EmailBody := EmailBody.Replace('[Account No.]', SavingsAccount."No.");
        EmailBody := EmailBody.Replace('[Account No]', SavingsAccount."No.");
        EmailBody := EmailBody.Replace('[Product Name]', SavingsAccount."Product Name");
        EmailBody := EmailBody.Replace('[Product Type]', SavingsAccount."Product Type");
        EmailBody := EmailBody.Replace('[Product Category]', Format(SavingsAccount."Product Category"));
        EmailBody := EmailBody.Replace('[Child Name]', SavingsAccount."Child Name");
        EmailBody := EmailBody.Replace('[Junior Name]', SavingsAccount."Child Name");
        exit(EmailBody);
    end;

    local procedure BuildLoanEmailBody(Member: Record Members; Loan: Record Loans): Text
    var
        EmailBody: Text;
    begin
        EmailBody := Rec."Email Body";
        ReplaceMemberPlaceholders(EmailBody, Member);
        EmailBody := EmailBody.Replace('[Loan No.]', Loan."Loan No.");
        EmailBody := EmailBody.Replace('[Loan No]', Loan."Loan No.");
        EmailBody := EmailBody.Replace('[Loan Account No.]', Loan."Loan Account");
        EmailBody := EmailBody.Replace('[Loan Account No]', Loan."Loan Account");
        EmailBody := EmailBody.Replace('[Loan Product]', Loan."Loan Product Type Name");
        EmailBody := EmailBody.Replace('[Loan Product Type]', Loan."Loan Product Type");
        EmailBody := EmailBody.Replace('[Loan Product Type Name]', Loan."Loan Product Type Name");
        EmailBody := EmailBody.Replace('[Loan Details]', StrSubstNo('%1 - %2', Loan."Loan No.", Loan."Loan Product Type Name"));
        //EmailBody := EmailBody.Replace('[Installments]', Format(Loan.Installments));
        //EmailBody := EmailBody.Replace('[Monthly Installment]', Format(Loan.Repayment));
        //EmailBody := EmailBody.Replace('[Monthly Repayment]', Format(Loan.Repayment));
        exit(EmailBody);
    end;

    local procedure BuildLoansEmailBody(Member: Record Members): Text
    var
        Loan: Record Loans;
        EmailBody: Text;
        LoanAccountNos: Text;
        LoanProducts: Text;
        LoanProductTypes: Text;
        LoanDetails: Text;
        Installments: Text;
        MonthlyRepayments: Text;
    begin
        EmailBody := Rec."Email Body";
        ReplaceMemberPlaceholders(EmailBody, Member);

        Loan.Reset();
        Loan.SetRange("Member No.", Member."No.");
        Loan.SetFilter("Total Outstanding Balance", '>0');
        if Loan.FindSet() then
            repeat
                AppendEmailListValue(LoanAccountNos, Loan."Loan Account");
                AppendEmailListValue(LoanProducts, Loan."Loan Product Type Name");
                AppendEmailListValue(LoanProductTypes, Loan."Loan Product Type");
                AppendEmailListValue(LoanDetails, StrSubstNo('%1 - %2', Loan."Loan No.", Loan."Loan Product Type Name"));
                AppendEmailListValue(Installments, Format(Loan.Installments));
                AppendEmailListValue(MonthlyRepayments, Format(Loan.Repayment));
            until Loan.Next() = 0;

        EmailBody := EmailBody.Replace('[Loan No.]', LoanDetails);
        EmailBody := EmailBody.Replace('[Loan No]', LoanDetails);
        EmailBody := EmailBody.Replace('[Loan Account No.]', LoanAccountNos);
        EmailBody := EmailBody.Replace('[Loan Account No]', LoanAccountNos);
        EmailBody := EmailBody.Replace('[Loan Product]', LoanProducts);
        EmailBody := EmailBody.Replace('[Loan Product Type]', LoanProductTypes);
        EmailBody := EmailBody.Replace('[Loan Product Type Name]', LoanProducts);
        EmailBody := EmailBody.Replace('[Loan Details]', LoanDetails);
        //EmailBody := EmailBody.Replace('[Installments]', Installments);
        //EmailBody := EmailBody.Replace('[Monthly Installment]', MonthlyRepayments);
        //EmailBody := EmailBody.Replace('[Monthly Repayment]', MonthlyRepayments);
        exit(EmailBody);
    end;

    local procedure BuildSavingsAccountsEmailBody(Member: Record Members; FilterType: Enum "Bulk Sms Filter Type"): Text
    var
        SavingsAccount: Record "Savings Accounts";
        EmailBody: Text;
        AccountNos: Text;
        ProductNames: Text;
        ProductTypes: Text;
        ProductCategories: Text;
        ChildNames: Text;
        JuniorAccountDetails: Text;
    begin
        if FilterType = FilterType::JuniorAccount then
            exit(BuildJuniorAccountsEmailBody(Member));

        EmailBody := Rec."Email Body";
        ReplaceMemberPlaceholders(EmailBody, Member);

        SavingsAccount.Reset();
        SavingsAccount.SetRange("Member No.", Member."No.");
        ApplySavingsFilter(SavingsAccount, FilterType);
        if SavingsAccount.FindSet() then
            repeat
                AppendEmailListValue(AccountNos, SavingsAccount."No.");
                AppendEmailListValue(ProductNames, SavingsAccount."Product Name");
                AppendEmailListValue(ProductTypes, SavingsAccount."Product Type");
                AppendEmailListValue(ProductCategories, Format(SavingsAccount."Product Category"));
                AppendEmailListValue(ChildNames, GetJuniorName(SavingsAccount));
                AppendEmailListValue(JuniorAccountDetails, GetJuniorAccountDetail(SavingsAccount));
            until SavingsAccount.Next() = 0;

        if FilterType = FilterType::JuniorAccount then begin
            EmailBody := EmailBody.Replace('[Savings Account No.]', JuniorAccountDetails);
            EmailBody := EmailBody.Replace('[Savings Account No]', JuniorAccountDetails);
            EmailBody := EmailBody.Replace('[Account No.]', JuniorAccountDetails);
            EmailBody := EmailBody.Replace('[Account No]', JuniorAccountDetails);
        end else begin
            EmailBody := EmailBody.Replace('[Savings Account No.]', AccountNos);
            EmailBody := EmailBody.Replace('[Savings Account No]', AccountNos);
            EmailBody := EmailBody.Replace('[Account No.]', AccountNos);
            EmailBody := EmailBody.Replace('[Account No]', AccountNos);
        end;
        EmailBody := EmailBody.Replace('[Product Name]', ProductNames);
        EmailBody := EmailBody.Replace('[Product Type]', ProductTypes);
        EmailBody := EmailBody.Replace('[Product Category]', ProductCategories);
        EmailBody := EmailBody.Replace('[Child Name]', ChildNames);
        EmailBody := EmailBody.Replace('[Junior Name]', ChildNames);
        exit(EmailBody);
    end;

    local procedure BuildJuniorAccountsEmailBody(Member: Record Members): Text
    var
        SavingsAccount: Record "Savings Accounts";
        EmailBody: Text;
        JuniorAccountDetails: Text;
    begin
        SavingsAccount.Reset();
        SavingsAccount.SetRange("Member No.", Member."No.");
        ApplySavingsFilter(SavingsAccount, "Bulk Sms Filter Type"::JuniorAccount);
        if SavingsAccount.FindSet() then
            repeat
                AppendEmailListValue(JuniorAccountDetails, GetJuniorAccountDetail(SavingsAccount));
            until SavingsAccount.Next() = 0;

        EmailBody := StrSubstNo(
            '<p>Dear %1,</p><p>The following junior accounts are registered under your membership:<br>%2</p><p>Regards,<br>United Women SACCO</p>',
            Member."First Name",
            JuniorAccountDetails);
        exit(EmailBody);
    end;

    local procedure GetJuniorAccountDetail(SavingsAccount: Record "Savings Accounts"): Text
    begin
        exit(StrSubstNo('%1 - %2', GetJuniorName(SavingsAccount), SavingsAccount."No."));
    end;

    local procedure GetJuniorName(SavingsAccount: Record "Savings Accounts"): Text
    begin
        if SavingsAccount."Child Name" <> '' then
            exit(SavingsAccount."Child Name");

        exit(SavingsAccount.Name);
    end;

    local procedure AppendEmailListValue(var CombinedValues: Text; ValueToAppend: Text)
    begin
        if ValueToAppend = '' then
            exit;

        if CombinedValues <> '' then
            CombinedValues += '<br>';
        CombinedValues += ValueToAppend;
    end;

    local procedure ReplaceMemberPlaceholders(var EmailBody: Text; Member: Record Members)
    begin
        EmailBody := EmailBody.Replace('[First Name]', Member."First Name");
        EmailBody := EmailBody.Replace('[Member Name]', Member.Name);
        EmailBody := EmailBody.Replace('[Member No.]', Member."No.");
        EmailBody := EmailBody.Replace('[Member No]', Member."No.");
        EmailBody := EmailBody.Replace('[Email]', Member."E-Mail");
        EmailBody := EmailBody.Replace('[Mobile No.]', Member."Mobile Phone No.");
        EmailBody := EmailBody.Replace('[Mobile No]', Member."Mobile Phone No.");
    end;

    local procedure UpdateEmailLineBodies()
    var
        BulkEmailLine: Record "Bulk Email Lines";
        Member: Record Members;
        SavingsAccount: Record "Savings Accounts";
        Loan: Record Loans;
        EmailBody: Text;
    begin
        BulkEmailLine.Reset();
        BulkEmailLine.SetRange(No, Rec.No);
        if BulkEmailLine.FindSet() then
            repeat
                if Member.Get(BulkEmailLine."Member No.") then begin
                    if (Rec."Email Type" = Rec."Email Type"::Everyone) and
                       (Rec."Filter Type" = Rec."Filter Type"::MemberWithLoanBalance)
                    then
                        EmailBody := BuildLoansEmailBody(Member)
                    else if (Rec."Email Type" = Rec."Email Type"::Everyone) and
                            (Rec."Filter Type" = Rec."Filter Type"::JuniorAccount)
                    then
                        EmailBody := BuildSavingsAccountsEmailBody(Member, Rec."Filter Type")
                    else if GetLoanForEmailLine(BulkEmailLine, Loan) then
                        EmailBody := BuildLoanEmailBody(Member, Loan)
                    else
                        if GetSavingsAccountForEmailLine(BulkEmailLine, SavingsAccount) then
                            EmailBody := BuildSavingsEmailBody(Member, SavingsAccount)
                        else begin
                            EmailBody := Rec."Email Body";
                            ReplaceMemberPlaceholders(EmailBody, Member);
                        end;

                    SetOptionalLineField(BulkEmailLine, 'Email Body', EmailBody);
                    SetOptionalLineField(BulkEmailLine, 'Body', EmailBody);
                    SetOptionalLineField(BulkEmailLine, 'Message', EmailBody);
                    SetOptionalLineField(BulkEmailLine, 'Message Body', EmailBody);
                    SetOptionalLineField(BulkEmailLine, 'Email Message', EmailBody);
                    BulkEmailLine.Modify(true);
                end;
            until BulkEmailLine.Next() = 0;
    end;

    local procedure GetSavingsAccountForEmailLine(BulkEmailLine: Record "Bulk Email Lines"; var SavingsAccount: Record "Savings Accounts"): Boolean
    var
        SavingsAccountNo: Text;
    begin
        SavingsAccountNo := GetOptionalLineFieldText(BulkEmailLine, 'Savings Account No.');
        if SavingsAccountNo = '' then
            SavingsAccountNo := GetOptionalLineFieldText(BulkEmailLine, 'Savings Account No');
        if SavingsAccountNo = '' then
            SavingsAccountNo := GetOptionalLineFieldText(BulkEmailLine, 'Account No.');
        if SavingsAccountNo = '' then
            SavingsAccountNo := GetOptionalLineFieldText(BulkEmailLine, 'Account No');

        if SavingsAccountNo <> '' then
            exit(SavingsAccount.Get(CopyStr(SavingsAccountNo, 1, MaxStrLen(SavingsAccount."No."))));

        if Rec.Product = '' then
            exit(false);

        SavingsAccount.Reset();
        SavingsAccount.SetRange("Member No.", BulkEmailLine."Member No.");
        SavingsAccount.SetRange("Product Type", Rec.Product);
        exit(SavingsAccount.FindFirst());
    end;

    local procedure GetLoanForEmailLine(BulkEmailLine: Record "Bulk Email Lines"; var Loan: Record Loans): Boolean
    var
        LoanNo: Text;
    begin
        LoanNo := GetOptionalLineFieldText(BulkEmailLine, 'Loan No.');
        if LoanNo = '' then
            LoanNo := GetOptionalLineFieldText(BulkEmailLine, 'Loan No');

        if LoanNo <> '' then
            exit(Loan.Get(CopyStr(LoanNo, 1, MaxStrLen(Loan."Loan No."))));

        Loan.Reset();
        Loan.SetRange("Member No.", BulkEmailLine."Member No.");
        Loan.SetFilter("Total Outstanding Balance", '>0');
        exit(Loan.FindFirst());
    end;

    local procedure CreateEmailLine(Member: Record Members; AllowDuplicateEmail: Boolean; var BulkEmailLine: Record "Bulk Email Lines"): Boolean
    var
        ExistingLine: Record "Bulk Email Lines";
    begin
        if Member."E-Mail" = '' then
            exit(false);

        if not AllowDuplicateEmail then begin
            ExistingLine.Reset();
            ExistingLine.SetRange(No, Rec.No);
            ExistingLine.SetRange("E-Mail", Member."E-Mail");
            if ExistingLine.FindFirst() then
                exit(false);
        end;

        BulkEmailLine.Init();
        BulkEmailLine.No := Rec.No;
        BulkEmailLine.Validate("Member No.", Member."No.");
        if BulkEmailLine."E-Mail" = '' then
            BulkEmailLine."E-Mail" := Member."E-Mail";
        exit(BulkEmailLine.Insert(true));
    end;

    local procedure SetOptionalLineField(var BulkEmailLine: Record "Bulk Email Lines"; FieldName: Text; FieldValue: Text)
    var
        BulkEmailLineRef: RecordRef;
        BulkEmailLineFieldRef: FieldRef;
        FieldIndex: Integer;
        DecimalValue: Decimal;
        IntegerValue: Integer;
    begin
        if FieldValue = '' then
            exit;

        BulkEmailLineRef.GetTable(BulkEmailLine);
        for FieldIndex := 1 to BulkEmailLineRef.FieldCount do begin
            BulkEmailLineFieldRef := BulkEmailLineRef.FieldIndex(FieldIndex);
            if BulkEmailLineFieldRef.Name = FieldName then begin
                case BulkEmailLineFieldRef.Type() of
                    FieldType::Code,
                    FieldType::Text:
                        BulkEmailLineFieldRef.Value := CopyStr(FieldValue, 1, BulkEmailLineFieldRef.Length);
                    FieldType::Decimal:
                        if Evaluate(DecimalValue, FieldValue) then
                            BulkEmailLineFieldRef.Value := DecimalValue;
                    FieldType::Integer:
                        if Evaluate(IntegerValue, FieldValue) then
                            BulkEmailLineFieldRef.Value := IntegerValue;
                    else
                        BulkEmailLineFieldRef.Value := FieldValue;
                end;
                BulkEmailLineRef.SetTable(BulkEmailLine);
                exit;
            end;
        end;
    end;

    local procedure GetOptionalLineFieldText(BulkEmailLine: Record "Bulk Email Lines"; FieldName: Text): Text
    var
        BulkEmailLineRef: RecordRef;
        BulkEmailLineFieldRef: FieldRef;
        FieldIndex: Integer;
    begin
        BulkEmailLineRef.GetTable(BulkEmailLine);
        for FieldIndex := 1 to BulkEmailLineRef.FieldCount do begin
            BulkEmailLineFieldRef := BulkEmailLineRef.FieldIndex(FieldIndex);
            if BulkEmailLineFieldRef.Name = FieldName then
                exit(Format(BulkEmailLineFieldRef.Value));
        end;

        exit('');
    end;
    //updated code to include advanced member status filters for bulk email generation
    local procedure ShouldInsertLine(MemberNo: Code[20]; FilterType: Enum "Bulk Sms Filter Type"): Boolean
    begin
        case FilterType of
            FilterType::DormantWithDeposits:
                exit(HasSavings(MemberNo, true, FilterType));
            FilterType::MembersWithOutLoans:
                exit(not HasAnyLoan(MemberNo));
            FilterType::MemberWithLoanBalance:
                exit(HasActiveLoan(MemberNo));
            FilterType::MemberActiveWithDeposits:
                exit(HasSavings(MemberNo, true, FilterType));
            FilterType::MemberActiveWithNoDeposits:
                exit(not HasSavings(MemberNo, true, FilterType));
            FilterType::ActiveMemberFosaAccount:
                exit(HasSavings(MemberNo, false, FilterType));
            FilterType::DormantMemberWithFosaAccount:
                exit(HasSavings(MemberNo, false, FilterType));
            FilterType::MemberWithFixedDeposits:
                exit(HasSavings(MemberNo, false, FilterType));
            FilterType::JuniorAccount:
                exit(HasSavings(MemberNo, false, FilterType));
            FilterType::HolidaySavings:
                exit(HasSavings(MemberNo, false, FilterType));
        end;
        exit(false);
    end;

    local procedure ApplyAdvancedMemberStatusFilter(var Member: Record Members; FilterType: Enum "Bulk Sms Filter Type")
    begin
        case FilterType of
            FilterType::DormantWithDeposits,
            FilterType::DormantMemberWithFosaAccount:
                Member.SetRange("Member Status", Member."Member Status"::Dormant);
            FilterType::ActiveMemberFosaAccount,
            FilterType::MemberActiveWithDeposits,
            FilterType::MemberActiveWithNoDeposits:
                Member.SetRange("Member Status", Member."Member Status"::Active);
        end;
    end;

    local procedure HasSavings(MemberNo: Code[20]; CheckBalance: Boolean; FilterType: Enum "Bulk Sms Filter Type"): Boolean
    var
        Savings: Record "Savings Accounts";
    begin
        Savings.Reset();
        Savings.SetRange("Member No.", MemberNo);
        if CheckBalance then
            Savings.SetFilter("Balance (LCY)", '>0');
        if (FilterType = FilterType::ActiveMemberFosaAccount) or
           (FilterType = FilterType::DormantMemberWithFosaAccount)
        then
            Savings.SetRange("Product Category", Savings."Product Category"::"Ordinary Savings")
        else
            if FilterType = FilterType::MemberWithFixedDeposits then
                Savings.SetRange("Product Category", Savings."Product Category"::"Fixed Deposit")
            else
                if FilterType = FilterType::JuniorAccount then
                    Savings.SetRange("Product Category", Savings."Product Category"::"Junior Savings")
                else
                    if FilterType = FilterType::HolidaySavings then
                        Savings.SetRange("Product Category", Savings."Product Category"::"Holiday Savings")
                    else
                        Savings.SetRange("Product Category", Savings."Product Category"::"Deposit Contribution");

        exit(Savings.FindFirst());
    end;

    local procedure InsertSavingsEmailLinesForFilter(Member: Record Members; FilterType: Enum "Bulk Sms Filter Type"): Integer
    var
        Savings: Record "Savings Accounts";
        GeneratedCount: Integer;
    begin
        Savings.Reset();
        Savings.SetRange("Member No.", Member."No.");
        ApplySavingsFilter(Savings, FilterType);

        if FilterType = FilterType::JuniorAccount then begin
            if Savings.FindFirst() then
                if TryInsertEmailLineForSavingsAccounts(Member, FilterType) then
                    exit(1);
            exit(0);
        end;

        if Savings.FindSet() then
            repeat
                if TryInsertEmailLineForSavings(Member, Savings) then
                    GeneratedCount += 1;
            until Savings.Next() = 0;

        exit(GeneratedCount);
    end;

    local procedure TryInsertEmailLineForSavingsAccounts(Member: Record Members; FilterType: Enum "Bulk Sms Filter Type"): Boolean
    var
        BulkEmailLine: Record "Bulk Email Lines";
        EmailBody: Text;
    begin
        if not CreateEmailLine(Member, false, BulkEmailLine) then
            exit(false);

        EmailBody := BuildSavingsAccountsEmailBody(Member, FilterType);
        SetOptionalLineField(BulkEmailLine, 'Email Body', EmailBody);
        SetOptionalLineField(BulkEmailLine, 'Body', EmailBody);
        SetOptionalLineField(BulkEmailLine, 'Message', EmailBody);

        exit(BulkEmailLine.Modify(true));
    end;

    local procedure IsSavingsFilter(FilterType: Enum "Bulk Sms Filter Type"): Boolean
    begin
        exit(FilterType in [
            FilterType::DormantWithDeposits,
            FilterType::MemberActiveWithDeposits,
            FilterType::ActiveMemberFosaAccount,
            FilterType::DormantMemberWithFosaAccount,
            FilterType::MemberWithFixedDeposits,
            FilterType::JuniorAccount,
            FilterType::HolidaySavings]);
    end;

    local procedure ApplySavingsFilter(var Savings: Record "Savings Accounts"; FilterType: Enum "Bulk Sms Filter Type")
    begin
        case FilterType of
            FilterType::DormantWithDeposits,
            FilterType::MemberActiveWithDeposits:
                begin
                    Savings.SetRange("Product Category", Savings."Product Category"::"Deposit Contribution");
                    Savings.SetFilter("Balance (LCY)", '>0');
                end;
            FilterType::ActiveMemberFosaAccount,
            FilterType::DormantMemberWithFosaAccount:
                Savings.SetRange("Product Category", Savings."Product Category"::"Ordinary Savings");
            FilterType::MemberWithFixedDeposits:
                Savings.SetRange("Product Category", Savings."Product Category"::"Fixed Deposit");
            FilterType::JuniorAccount:
                Savings.SetRange("Product Category", Savings."Product Category"::"Junior Savings");
            FilterType::HolidaySavings:
                Savings.SetRange("Product Category", Savings."Product Category"::"Holiday Savings");
        end;
    end;

    local procedure HasAnyLoan(MemberNo: Code[20]): Boolean
    var
        Loans: Record Loans;
    begin
        Loans.Reset();
        Loans.SetRange("Member No.", MemberNo);
        exit(Loans.FindFirst());
    end;

    local procedure HasActiveLoan(MemberNo: Code[20]): Boolean
    var
        Loans: Record Loans;
    begin
        Loans.Reset();
        Loans.SetRange("Member No.", MemberNo);
        Loans.SetFilter("Total Outstanding Balance", '>0');
        exit(Loans.FindFirst());
    end;
}
