page 50723 "Direct Debit Card"
{
    ApplicationArea = All;
    Caption = 'Direct Debit Card';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Salary Header";

    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Importation,Validation,Posting';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(DestinationTransactionType; Rec."Destination Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = TransType;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec."Income Type" := Rec."Income Type"::"Direct Debit";
                    end;
                }
                field(DontSendSMS; Rec."Dont Send SMS")
                {
                    ApplicationArea = Basic;
                }

                field(Postingdate; Rec."Posting date")
                {
                    ApplicationArea = Basic;
                    Editable = Pdate;
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = Basic;
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = AccNo;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec."Process Type" := Rec."Process Type"::"Branch Process";
                        Rec."Recovery Type" := Rec."Recovery Type"::"Full Amount";
                    end;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentNo; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
                field("Staff Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = Basic;
                    Editable = Rmarks;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = Rmarks;
                }
                field("Loan Balance Date"; Rec."Loan Balance Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = Amnt;
                }
                field(ChequeNo; Rec."Cheque No.")
                {
                    Caption = 'Cheque/ETF No.';
                    ApplicationArea = Basic;
                }
                field("Batch Entries"; Rec."Batch Entries")
                {
                }
                field("No. of Batches"; Rec."No. of Batches")
                {
                    Editable = false;
                }
                field(ScheduledAmount; Rec."Scheduled Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Lines Amount"; Rec."Posting Lines Amount")
                {
                    ApplicationArea = Basic;
                }
                field(TotalCount; Rec."Total Count")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(PostedEntries; Rec."Posted Entries")
                {
                    ApplicationArea = Basic;
                }
                field(UnPostedEntries; Rec."UnPosted Entries")
                {
                    ApplicationArea = Basic;
                }
                field(UnidentifiedAmount; Rec."Unidentified Amount")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerCode; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = EmployerC;
                }
                field("Salary Variance"; Rec."Salary Variance")
                {
                    ApplicationArea = Basic;
                }
                field(LastLoanIssueDate; Rec."Last Loan Issue Date")
                {
                    ApplicationArea = Basic;
                    Editable = LastloanDate;
                    Visible = false;
                }
                field(EnteredBy; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(ProcessType; Rec."Process Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(IncomeType; Rec."Income Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RecoveryType; Rec."Recovery Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Salary Month"; Rec."Salary Month")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Recover Fosa Loans"; Rec."Recover Fosa Loans")
                {
                    ApplicationArea = Basic;

                }
                field("Recover Bosa Loans"; Rec."Recover Bosa Loans")
                {
                    ApplicationArea = Basic;

                }
                field(UnidentifiedAccountNo; Rec."Unidentified Account No")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(PostedBy; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(d; "Salary Lines")
            {
                SubPageLink = "Salary Header No." = field(No);
                SubPageView = sorting("Salary Header No.", "No.") order(Ascending);
            }
            part(e; "Salary Posting Buffer")
            {
                SubPageLink = "Header No." = field(No);
                SubPageView = sorting("Header No.", "Entry No.") order(Ascending);
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Import Salary")
            {
                ApplicationArea = Basic;
                Caption = 'Import Payments';
                Image = Import;
                Promoted = true;
                //RunObject = XMLport "Import Salaries";
                PromotedCategory = Category7;
                PromotedIsBig = true;

                trigger OnAction()
                begin


                    Message('Ensure the document is as follows: \1. Payroll No/\2. Amount\\ - Document Format should be Excel and Should include the Headers');

                    if Confirm('Are you sure you want to Import Salary?') then begin

                        Rec.ImportCheckOffLinesFromExcel();

                    end;
                end;
            }

            action("Import Payments XML")
            {
                ApplicationArea = Basic;
                Caption = 'Import Payments XML';
                Image = ImportExport;
                Promoted = true;
                RunObject = XMLport "Import Payments";
                PromotedCategory = Category7;
                PromotedIsBig = true;

            }
            group(Process)
            {
                Caption = 'Process';


                action(DefaulterRec)
                {
                    ApplicationArea = Basic;
                    Image = ConfirmAndPrint;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Sky: Codeunit "Sky MBanking";
                    begin
                        if Confirm('Are you sure you want to recover defaulters?') then begin
                            sky.RecoverDefaultedInstantLoans(Rec.No, Rec."Posting date");
                        end;
                    end;
                }

                action("Validate with Account")
                {
                    ApplicationArea = Basic;
                    Image = Translation;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SalaryLines: Record "Salary Lines";
                        SavingsAccounts: Record "Savings Accounts";
                        StrMenuTxt: label '&Account No.,&OldMemberNo.,&ID No';
                        Selection: Integer;
                        Members: Record Members;
                    begin
                        //TESTFIELD("Employer Code");

                        Selection := StrMenu(StrMenuTxt, 1);

                        if Selection = 0 then
                            exit;

                        //ERROR('%1',Selection);

                        if Selection = 1 then begin
                            SalaryLines.Reset;
                            SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
                            if SalaryLines.Find('-') then begin
                                repeat
                                    SavingsAccounts.Reset;
                                    SavingsAccounts.SetRange("No.", SalaryLines."Account No.");
                                    if SavingsAccounts.Find('-') then begin

                                        if SavingsAccounts.Blocked <> SavingsAccounts.Blocked::" " then
                                            SalaryLines."Blocked Accounts" := true
                                        else
                                            SalaryLines."Blocked Accounts" := false;

                                        if Members.Get(SavingsAccounts."Member No.") then begin

                                            SalaryLines."Employer Code" := Members."Employer Code";

                                            if Rec."Process Type" = Rec."process type"::"General Process" then begin
                                                if SavingsAccounts."Global Dimension 1 Code" <> '' then
                                                    SalaryLines."Global Dimension 1 Code" := SavingsAccounts."Global Dimension 1 Code"
                                                else
                                                    SalaryLines."Global Dimension 1 Code" := Members."Global Dimension 1 Code";

                                                if SavingsAccounts."Global Dimension 2 Code" <> '' then
                                                    SalaryLines."Global Dimension 2 Code" := SavingsAccounts."Global Dimension 2 Code"
                                                else
                                                    SalaryLines."Global Dimension 2 Code" := Members."Global Dimension 2 Code";
                                            end
                                            else
                                                if Rec."Process Type" = Rec."process type"::"Branch Process" then begin
                                                    UserSetup.Get(UserId);
                                                    SalaryLines."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                                                end
                                                else
                                                    Error('Process Type Must Have a Value');
                                        end;

                                        //SalaryLines."Member No.":=SavingsAccounts."Member No.";
                                        SalaryLines."Member No." := SavingsAccounts."Member No.";
                                        SalaryLines."Staff No." := SavingsAccounts."Payroll/Staff No.";
                                        SalaryLines.Name := SavingsAccounts.Name;
                                        SalaryLines."Account Not Found" := false;
                                        SalaryLines."ID No." := Members."ID No.";
                                        SalaryLines."Account No." := SavingsAccounts."No.";
                                        SalaryLines.Status := SavingsAccounts.Status;
                                        SalaryLines.Modify;
                                    end
                                    else
                                        SalaryLines."Account Not Found" := true;

                                    SalaryLines.Modify;
                                until SalaryLines.Next = 0;
                            end;
                        end
                        else begin
                            SalaryLines.Reset;
                            SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
                            if SalaryLines.Find('-') then begin
                                repeat

                                    Members.Reset;

                                    if Selection = 3 then
                                        Members.SetRange("ID No.", SalaryLines."ID No.")
                                    else begin
                                        Members.SetRange("Old Member No.", SalaryLines."Old Account No.");
                                        //Members.SETRANGE("Employer Code","Employer Code");
                                    end;
                                    if Members.FindFirst then begin

                                        SavingsAccounts.Reset;
                                        SavingsAccounts.SetRange("Member No.", Members."No.");
                                        SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Ordinary Savings");
                                        if SavingsAccounts.Find('-') then begin
                                            SalaryLines."Account Not Found" := false;


                                            SalaryLines."Employer Code" := Members."Employer Code";

                                            if Rec."Process Type" = Rec."process type"::"General Process" then begin
                                                SalaryLines."Global Dimension 2 Code" := Members."Global Dimension 2 Code";
                                            end
                                            else
                                                if Rec."Process Type" = Rec."process type"::"Branch Process" then begin
                                                    UserSetup.Get(UserId);
                                                    SalaryLines."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                                                end
                                                else
                                                    Error('Process Type Must Have a Value');


                                            if SavingsAccounts.Blocked <> SavingsAccounts.Blocked::" " then
                                                SalaryLines."Blocked Accounts" := true
                                            else
                                                SalaryLines."Blocked Accounts" := false;
                                            // MESSAGE('HAHAHA %1',SalaryLines."Account No.");

                                            SalaryLines."Account No." := SavingsAccounts."No.";
                                            SalaryLines."ID No." := SavingsAccounts."ID No.";
                                            SalaryLines."Member No." := SavingsAccounts."Member No.";
                                            SalaryLines.Name := SavingsAccounts.Name;
                                            SalaryLines.Status := SavingsAccounts.Status;
                                            SalaryLines."Employer Code" := Members."Employer Code";
                                            SalaryLines."Global Dimension 1 Code" := SavingsAccounts."Global Dimension 1 Code";
                                        end;
                                    end
                                    else
                                        SalaryLines."Account Not Found" := true;

                                    SalaryLines.Modify;

                                until SalaryLines.Next = 0;
                            end;
                        end;


                        Rec.Validated := true;
                        Rec.Modify;
                        Message('Salary Lines Validated sucessfully');
                    end;
                }
                action("Validate with Staff No")
                {
                    ApplicationArea = Basic;
                    Image = Translation;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SalaryLines: Record "Salary Lines";
                        SavingsAccounts: Record "Savings Accounts";
                        StrMenuTxt: label '&Staff No.';
                        Selection: Integer;
                        Members: Record Members;
                        CurrentRecordNo: Integer;
                        NoOfRecords: Integer;
                        dWindow: Dialog;


                    begin
                        //TESTFIELD("Employer Code");

                        Selection := StrMenu(StrMenuTxt, 1);

                        if Selection = 0 then
                            exit;

                        //ERROR('%1',Selection);

                        if Selection = 1 then begin
                            SalaryLines.Reset;
                            SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
                            if SalaryLines.FindSet(true) then begin


                                //if not PostLinebyLine then begin
                                dWindow.Open('Validating Lines:              #1#########\'
                                                    + 'Accounts:             #2#########\'
                                                    + 'Counter:              #3#########\'
                                                    + 'Progress:             @4@@@@@@@@@\'
                                                    + 'Press Esc to abort');

                                CurrentRecordNo := 0;
                                NoOfRecords := 0;
                                //end;

                                //if not PostLinebyLine then begin
                                NoOfRecords := SalaryLines.Count;
                                dWindow.Update(2, NoOfRecords);
                                //end;
                                repeat
                                    dWindow.Update(1, SalaryLines."Staff No.");
                                    CurrentRecordNo += 1;


                                    //if not PostLinebyLine then begin
                                    dWindow.Update(3, CurrentRecordNo);
                                    dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));


                                    SavingsAccounts.Reset;
                                    SavingsAccounts.SetRange("Payroll/Staff No.", SalaryLines."Staff No.");
                                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Ordinary Savings");
                                    if SavingsAccounts.Find('-') then begin

                                        if SavingsAccounts.Blocked <> SavingsAccounts.Blocked::" " then
                                            SalaryLines."Blocked Accounts" := true
                                        else
                                            SalaryLines."Blocked Accounts" := false;

                                        if Members.Get(SavingsAccounts."Member No.") then begin

                                            SalaryLines."Employer Code" := Members."Employer Code";

                                            if Rec."Process Type" = Rec."process type"::"General Process" then begin
                                                if SavingsAccounts."Global Dimension 1 Code" <> '' then
                                                    SalaryLines."Global Dimension 1 Code" := SavingsAccounts."Global Dimension 1 Code"
                                                else
                                                    SalaryLines."Global Dimension 1 Code" := Members."Global Dimension 1 Code";

                                                if SavingsAccounts."Global Dimension 2 Code" <> '' then
                                                    SalaryLines."Global Dimension 2 Code" := SavingsAccounts."Global Dimension 2 Code"
                                                else
                                                    SalaryLines."Global Dimension 2 Code" := Members."Global Dimension 2 Code";
                                            end
                                            else
                                                if Rec."Process Type" = Rec."process type"::"Branch Process" then begin
                                                    UserSetup.Get(UserId);
                                                    SalaryLines."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                                                end
                                                else
                                                    Error('Process Type Must Have a Value');
                                        end;

                                        //SalaryLines."Member No.":=SavingsAccounts."Member No.";
                                        SalaryLines."Member No." := SavingsAccounts."Member No.";
                                        SalaryLines.Name := SavingsAccounts.Name;
                                        SalaryLines."Account Not Found" := false;
                                        SalaryLines."ID No." := Members."ID No.";
                                        SalaryLines."Account No." := SavingsAccounts."No.";
                                        SalaryLines.Status := SavingsAccounts.Status;
                                    end
                                    else
                                        SalaryLines."Account Not Found" := true;

                                    SalaryLines.Modify;
                                until SalaryLines.Next = 0;
                                dWindow.Close();
                            end;
                        end
                        else begin
                            SalaryLines.Reset;
                            SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
                            if SalaryLines.Find('-') then begin
                                repeat

                                    Members.Reset;

                                    if Selection = 3 then
                                        Members.SetRange("ID No.", SalaryLines."ID No.")
                                    else begin
                                        Members.SetRange("Old Member No.", SalaryLines."Old Account No.");
                                        //Members.SETRANGE("Employer Code","Employer Code");
                                    end;
                                    if Members.FindFirst then begin

                                        SavingsAccounts.Reset;
                                        SavingsAccounts.SetRange("Member No.", Members."No.");
                                        SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Ordinary Savings");
                                        if SavingsAccounts.Find('-') then begin
                                            SalaryLines."Account Not Found" := false;


                                            SalaryLines."Employer Code" := Members."Employer Code";

                                            if Rec."Process Type" = Rec."process type"::"General Process" then begin
                                                SalaryLines."Global Dimension 2 Code" := Members."Global Dimension 2 Code";
                                            end
                                            else
                                                if Rec."Process Type" = Rec."process type"::"Branch Process" then begin
                                                    UserSetup.Get(UserId);
                                                    SalaryLines."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                                                end
                                                else
                                                    Error('Process Type Must Have a Value');


                                            if SavingsAccounts.Blocked <> SavingsAccounts.Blocked::" " then
                                                SalaryLines."Blocked Accounts" := true
                                            else
                                                SalaryLines."Blocked Accounts" := false;
                                            // MESSAGE('HAHAHA %1',SalaryLines."Account No.");

                                            SalaryLines."Account No." := SavingsAccounts."No.";
                                            SalaryLines."ID No." := SavingsAccounts."ID No.";
                                            SalaryLines."Member No." := SavingsAccounts."Member No.";
                                            SalaryLines.Name := SavingsAccounts.Name;
                                            SalaryLines.Status := SavingsAccounts.Status;
                                            SalaryLines."Employer Code" := Members."Employer Code";
                                            SalaryLines."Global Dimension 1 Code" := SavingsAccounts."Global Dimension 1 Code";
                                        end;
                                    end
                                    else
                                        SalaryLines."Account Not Found" := true;

                                    SalaryLines.Modify;

                                until SalaryLines.Next = 0;
                            end;
                        end;


                        Rec.Validated := true;
                        Rec.Modify;
                        Message('Salary Lines Validated sucessfully');
                    end;
                }

                action("Validate with Member No")
                {
                    ApplicationArea = Basic;
                    Image = Translation;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SalaryLines: Record "Salary Lines";
                        SavingsAccounts: Record "Savings Accounts";
                        StrMenuTxt: label '&Member No';
                        Selection: Integer;
                        Members: Record Members;
                    begin
                        //TESTFIELD("Employer Code");

                        Selection := StrMenu(StrMenuTxt, 1);

                        if Selection = 0 then
                            exit;

                        //ERROR('%1',Selection);

                        if Selection = 1 then begin
                            SalaryLines.Reset;
                            SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
                            if SalaryLines.Find('-') then begin
                                repeat
                                    SavingsAccounts.Reset;
                                    SavingsAccounts.SetRange("Member No.", SalaryLines."Staff No.");
                                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Ordinary Savings");
                                    if SavingsAccounts.Find('-') then begin

                                        if SavingsAccounts.Blocked <> SavingsAccounts.Blocked::" " then
                                            SalaryLines."Blocked Accounts" := true
                                        else
                                            SalaryLines."Blocked Accounts" := false;

                                        if Members.Get(SavingsAccounts."Member No.") then begin

                                            SalaryLines."Employer Code" := Members."Employer Code";

                                            if Rec."Process Type" = Rec."process type"::"General Process" then begin
                                                if SavingsAccounts."Global Dimension 1 Code" <> '' then
                                                    SalaryLines."Global Dimension 1 Code" := SavingsAccounts."Global Dimension 1 Code"
                                                else
                                                    SalaryLines."Global Dimension 1 Code" := Members."Global Dimension 1 Code";

                                                if SavingsAccounts."Global Dimension 2 Code" <> '' then
                                                    SalaryLines."Global Dimension 2 Code" := SavingsAccounts."Global Dimension 2 Code"
                                                else
                                                    SalaryLines."Global Dimension 2 Code" := Members."Global Dimension 2 Code";
                                            end
                                            else
                                                if Rec."Process Type" = Rec."process type"::"Branch Process" then begin
                                                    UserSetup.Get(UserId);
                                                    SalaryLines."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                                                end
                                                else
                                                    Error('Process Type Must Have a Value');
                                        end;

                                        //SalaryLines."Member No.":=SavingsAccounts."Member No.";
                                        SalaryLines."Member No." := SavingsAccounts."Member No.";
                                        //SalaryLines."Staff No." := SavingsAccounts."Payroll/Staff No.";
                                        SalaryLines.Name := SavingsAccounts.Name;
                                        SalaryLines."Account Not Found" := false;
                                        SalaryLines."ID No." := Members."ID No.";
                                        SalaryLines."Account No." := SavingsAccounts."No.";
                                        SalaryLines.Status := SavingsAccounts.Status;
                                        SalaryLines.Modify;
                                    end
                                    else
                                        SalaryLines."Account Not Found" := true;

                                    SalaryLines.Modify();
                                until SalaryLines.Next() = 0;
                            end;
                        end;

                        Rec.Validated := true;
                        Rec.Modify;
                        Message('Salary Lines Validated sucessfully');
                    end;
                }

                action("Update Pensioners Data")
                {
                    ApplicationArea = Basic;
                    Image = Translation;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        SalaryLines: Record "Salary Lines";
                        SavingsAccounts: Record "Savings Accounts";
                        StrMenuTxt: label '&Staff No.';
                        Selection: Integer;
                        Members: Record Members;
                        CurrentRecordNo: Integer;
                        NoOfRecords: Integer;
                        dWindow: Dialog;
                        Loans: Record loans;
                        STO: Record "Standing Order Header";


                    begin
                        //TESTFIELD("Employer Code");
                        Rec.TestField("Income Type", Rec."Income Type"::Pension);

                        //ERROR('%1',Selection);


                        SalaryLines.Reset;
                        SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
                        if SalaryLines.FindSet(true) then begin


                            //if not PostLinebyLine then begin
                            dWindow.Open('Updating Lines:              #1#########\'
                                                + 'Accounts:             #2#########\'
                                                + 'Counter:              #3#########\'
                                                + 'Progress:             @4@@@@@@@@@\'
                                                + 'Press Esc to abort');

                            CurrentRecordNo := 0;
                            NoOfRecords := 0;
                            //end;

                            //if not PostLinebyLine then begin
                            NoOfRecords := SalaryLines.Count;
                            dWindow.Update(2, NoOfRecords);
                            //end;
                            repeat
                                dWindow.Update(1, SalaryLines."Member No.");
                                CurrentRecordNo += 1;


                                //if not PostLinebyLine then begin
                                dWindow.Update(3, CurrentRecordNo);
                                dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

                                SalaryLines.testfield("Member No.");
                                if Members.Get(SalaryLines."Member No.") then begin

                                    if not Members.Pensioner then begin
                                        Members.Pensioner := true;
                                        Members.Modify();
                                    end;

                                    STO.Reset();
                                    STO.SetRange("Member No.", Members."No.");
                                    STO.SetRange("Income Type", STO."Income Type"::Salary);
                                    if STO.FindFirst() then begin
                                        STO.ModifyAll("Income Type", STO."Income Type"::Pension);
                                    end;


                                    Loans.Reset();
                                    Loans.SetRange("Member No.", Members."No.");
                                    Loans.SetRange("Repay Mode", Loans."Repay Mode"::Salary);
                                    if Loans.FindFirst() then begin
                                        Loans.ModifyAll("Repay Mode", Loans."Repay Mode"::Pension);
                                    end;


                                end;
                            until SalaryLines.Next = 0;
                            dWindow.Close();

                        end;

                    end;


                }
                action("Check for Mutiple Payments")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    var
                        SalaryLines: Record "Salary Lines";
                    begin

                        SalaryLines.Reset;
                        SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
                        if SalaryLines.Find('-') then
                            Report.Run(50257, true, false, SalaryLines);
                    end;
                }
                action("Loan Variance")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    var
                        SalaryLines: Record "Salary Lines";
                    begin

                        SalaryLines.Reset;
                        SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
                        if SalaryLines.Find('-') then
                            Report.Run(Report::"Salary Loan Variance", true, false, SalaryLines);
                    end;
                }

                action("Salaries With Loans")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    var
                        SalaryLines: Record "Salary Lines";
                    begin

                        SalaryLines.Reset;
                        SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
                        if SalaryLines.Find('-') then
                            Report.Run(50331, true, false, SalaryLines);
                    end;
                }

                action("Batch Lines")
                {
                    ApplicationArea = Basic;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Txt0000: label 'Checkoff Successfully Generated';
                    begin
                        Rec.CalcFields("Posted Entries");
                        Rec.TestField("Batch Entries");

                        if Rec."Posted Entries" > 0 then
                            Error('There are entries that have been posted you cannot Batch lines');

                        SaccoT.BatchSalary(Rec, false);
                        Rec.Modify();

                        Message('Process Completed');
                    end;
                }

            }
            group(ActionGroup64)
            {
                Caption = 'Post';
                action("Journal Transfer")
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //Rec.Status := Rec.Status::Approved;
                        //MODIFY;
                        //COMMIT;

                        if Rec."Process Type" = Rec."process type"::" " then
                            Error('Process Type Must have a value');

                        if Rec.Status <> Rec.Status::Approved then
                            Error('The salary batch has not been approved');

                        if Confirm('Are you sure you want to transfer these entries to Journal?') then
                            SaccoT.PostSalary(Rec, false);
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Posted, false);
                        Rec.TestField("Destination Transaction Type");
                        if Rec."Process Type" = Rec."process type"::" " then
                            Error('Process Type Must have a value');

                        if Rec.Status <> Rec.Status::Approved then
                            Error('The salary batch has not been approved');

                        if Confirm('Are you sure you want to POST this Income?') then
                            SaccoT.PostSalary(Rec, true);

                        Rec.ModifyAll(Rec.Posted, true);
                    end;
                }
                action(PostBuffer)
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Destination Transaction Type");
                        if Rec."Process Type" = Rec."process type"::" " then
                            Error('Process Type Must have a value');

                        if Rec.Status <> Rec.Status::Approved then
                            Error('The salary batch has not been approved');

                        if Confirm('Are you sure you want to POST this Income?') then begin

                            SaccoT.PostSalaryBuffer(Rec, true);

                            Rec.ModifyAll(Rec.Posted, true);
                        end

                    end;
                }
                action(PostSalaryLoanArrears)
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Destination Transaction Type");
                        if Rec."Process Type" = Rec."process type"::" " then
                            Error('Process Type Must have a value');

                        if Rec.Status <> Rec.Status::Approved then
                            Error('The salary batch has not been approved');

                        if Confirm('Are you sure you want to POST Loan Arrears?') then
                            SaccoT.PostSalaryLoanArrears(Rec);
                    end;
                }
                action(GenerateSalaryPostingBuffer)
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Destination Transaction Type");
                        if Rec."Process Type" = Rec."process type"::" " then
                            Error('Process Type Must have a value');

                        if Rec.Status <> Rec.Status::Approved then
                            Error('The salary batch has not been approved');



                        if Confirm('Are you sure you want to Generate Posting Lines?') then begin
                            //if Period = Period::"End Month" then
                            //  SaccoT.UpdateLoanSchedules(Rec);


                            // SaccoT.GenerateSalaryDeductions(Rec);
                            SaccoT.GenerateSalaryPostingBuffer(Rec);
                        end;
                    end;
                }

                action(ExpectedDeductions)
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    RunObject = page "Salary Expected Deductions";
                    RunPageLink = "Salary Header No." = field(No);

                }
                action(UpdateLoanSchedules)
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    visible = false;

                    trigger OnAction()
                    begin
                        Rec.TestField(Period, Rec.Period::"End Month");
                        Rec.TestField("Posting date");
                        Rec.TestField(Period, Rec.Period::"End Month");

                        //if Confirm('Are you sure you want to Update Loan Schedules for this Employer?') then begin
                        //  SaccoT.UpdateLoanSchedules(Rec);
                        //end;
                    end;
                }
                action("Toggle Posted")
                {
                    ApplicationArea = Basic;
                    Image = ReOpen;
                    Visible = true;
                    trigger OnAction()
                    var
                        DtldVendLedgEntry: Record "Savings Ledger Entry";
                        SalaryLines: Record "Salary Lines";
                        DocNoFound: Boolean;
                        User: Record User;
                        Done: Boolean;
                    begin

                        DtldVendLedgEntry.Reset();
                        DtldVendLedgEntry.SetRange("Document No.", Rec.No);
                        DtldVendLedgEntry.SetRange(Reversed, false);
                        DocNoFound := DtldVendLedgEntry.FindFirst();

                        if not DocNoFound and Rec.Posted then begin

                            SalaryLines.Reset();
                            SalaryLines.SetRange("Journal Posted", false);
                            SalaryLines.SetRange("Salary Header No.", Rec.No);
                            if SalaryLines.FindFirst() then begin
                                SalaryLines.ModifyAll(Posted, false);
                                SalaryLines.ModifyAll("Posted By", '');
                                SalaryLines.ModifyAll("Posting Date", 0D);
                                SalaryLines.ModifyAll("Posting Time", 0T);
                            end;

                            Rec.Posted := false;
                            Rec."Posted By" := '';
                            Rec.Modify();
                            Done := true;

                        end;

                        if DocNoFound and not Rec.Posted then begin

                            Rec.Posted := true;
                            if User.Get(Rec.SystemCreatedBy) then
                                Rec."Posted By" := User."User Name";
                            Rec.Modify();

                            SalaryLines.Reset();
                            SalaryLines.SetRange("Journal Posted", true);
                            SalaryLines.SetRange("Salary Header No.", Rec.No);
                            if SalaryLines.FindFirst() then begin
                                SalaryLines.ModifyAll(Posted, true);
                                SalaryLines.ModifyAll("Posted By", Rec."Posted By");
                                SalaryLines.ModifyAll("Posting Date", Rec."Posting date");
                            end;
                            Done := true;
                        end;

                        if Done then
                            Message('Updated Successfully.!')
                        else
                            Message('Updating the posted status to %1 is not permitted', (Not Rec.Posted));
                    end;
                }
                action(Link)
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var
                        Link: Text;
                    begin

                        Link := GetUrl(CurrentClientType, COMPANYNAME, Objecttype::Page, 22);
                    end;
                }
                action("Bonus Income Simulation")
                {
                    ApplicationArea = Basic;
                    //Image = "report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        SalaryHeader.Reset;
                        SalaryHeader.SetRange(No, Rec.No);
                        if SalaryHeader.Find('-') then
                            Report.Run(50295, true, false, SalaryHeader);
                    end;
                }
                action("Clear Posting Buffer")
                {
                    ApplicationArea = Basic;
                    Image = ClearFilter;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger onaction()
                    var
                        SalaryLines: Record "Salary Posting";
                    begin
                        IF CONFIRM('Are you sure you want to clear salary posting buffer') THEN BEGIN
                            SalaryLines.RESET;
                            SalaryLines.SETRANGE(SalaryLines."Document No.", Rec.No);
                            IF SalaryLines.FIND('-') THEN BEGIN
                                IF NOT CONFIRM('Existing Lines will be deleted. do you want to continue?') THEN
                                    ERROR('Aborted');
                                SalaryLines.DELETEALL;
                            END;
                        end

                    end;
                }
                action("Generate Staff Salary")
                {
                    ApplicationArea = Basic;
                    Image = GetEntries;

                    trigger OnAction()
                    var
                        PostingGroup: Record "Payroll Posting Group";
                        PeriodTrans: Record "Payroll Period Transactions";
                        PayrollCodes: Record "Payroll Codes";
                    begin

                        PayrollCodes.Reset();
                        PayrollCodes.SetRange("Transaction Type", PayrollCodes."Transaction Type"::"Net Pay");
                        if PayrollCodes.FindFirst() then begin


                            Rec.TESTFIELD("Income Type", Rec."Income Type"::"Staff Salary");

                            Rec."Account No" := PayrollCodes."GL Account";

                            IF CONFIRM('Are you sure you want to generate staff list') THEN BEGIN
                                SalaryLines.RESET;
                                SalaryLines.SETRANGE(SalaryLines."Salary Header No.", Rec.No);
                                IF SalaryLines.FIND('-') THEN BEGIN
                                    IF NOT CONFIRM('Existing Lines will be deleted. do you want to continue?') THEN
                                        ERROR('Aborted');
                                    SalaryLines.DELETEALL;
                                END;
                                LNo := 0;

                                HREmployees.RESET;
                                HREmployees.SETFILTER("Member No", '<>%1', '');
                                IF HREmployees.FINDFIRST THEN BEGIN
                                    REPEAT
                                        SavingsAccounts.Reset();
                                        SavingsAccounts.SetRange("Member No.", HREmployees."Member No");
                                        SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Ordinary Savings");
                                        IF SavingsAccounts.FindFirst() THEN BEGIN
                                            SavingsAccounts.calcfields("ID No.");
                                            SavingsAccounts.calcfields("Payroll/Staff No.");

                                            PeriodTrans.RESET;
                                            PeriodTrans.SETRANGE("Employee Code", HREmployees."No.");
                                            PeriodTrans.SETRANGE("Transaction Code", PayrollCodes."Transaction Code");
                                            PeriodTrans.SETRANGE("Payroll Period", Rec."Payroll Period");
                                            IF PeriodTrans.FIND('-') THEN BEGIN
                                                LNo += 1;
                                                SalaryLines.INIT;
                                                SalaryLines."Salary Header No." := Rec.No;
                                                SalaryLines."No." := LNo;
                                                SalaryLines."Staff No." := SavingsAccounts."Payroll/Staff No.";
                                                SalaryLines."Account No." := SavingsAccounts."No.";
                                                SalaryLines."Member No." := SavingsAccounts."Member No.";
                                                SalaryLines.Amount := round(PeriodTrans.Amount, 0.01);
                                                SalaryLines."ID No." := SavingsAccounts."ID No.";
                                                SalaryLines.Name := SavingsAccounts.Name;
                                                SalaryLines.INSERT;
                                            END;
                                        END;

                                    UNTIL HREmployees.NEXT = 0;
                                    MESSAGE('Process Completed');
                                END;

                            END;

                        end;


                    end;
                }
                action("Reverse Income")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        //SaccoT.ReverseSalary(Rec);
                    end;
                }
                action("Income Summary Report")
                {
                    ApplicationArea = Basic;
                    Image = SuggestGrid;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Posted);
                        SalaryHeader.Reset;
                        SalaryHeader.SetRange(No, Rec.No);
                        if SalaryHeader.Find('-') then
                            Report.Run(50507, true, false, SalaryHeader);

                        //52018524
                    end;
                }
                action("Duplicate Posting")
                {
                    ApplicationArea = Basic;
                    Image = SuggestGrid;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //TESTFIELD(Posted);
                        SalaryHeader.Reset;
                        SalaryHeader.SetRange(No, Rec.No);
                        if SalaryHeader.Find('-') then
                            Report.Run(50478, true, false, SalaryHeader);
                    end;
                }
            }
        }
        area(processing)
        {
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        NextofKIN: Record "Service Item";
                        ProductFactory: Record "Service Item";
                        SavingsAccountRegistration: Record "Service Item";
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        ApprovalEntry: Record "Approval Entry";
                    begin

                        CheckControls;


                        VarVariant := Rec;
                        //CalwideApprovals.CreateCustomTracker(VarVariant, No, 0, Documenttype::Salary, "Global Dimension 1 Code", "Global Dimension 2 Code", 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec.No);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice","Member Changes",STO,"Cheque Book App","Account Transfer","Teller Transaction","Micro Transaction",PV,"Petty Cash","Collateral Register","Collateral Return",CheckOff,"Bankers Cheque",Salary;
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::Salary;

                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec.No);
                        ApprovalTracker.SetRange("Document Type", DocumentType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin

                        if Rec.Status = Rec.Status::Pending then begin
                            VarVariant := Rec;
                            CalwideApprovals.CancelTracker(VarVariant, Rec.No);
                        end
                        else begin

                            if not Confirm('Are you sure you want to re-open this document?') then
                                exit;

                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl;
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControl;
    end;

    trigger OnOpenPage()
    begin
        UpdateControl;
    end;

    var
        SaccoT: Codeunit "Sacco Activities";
        TransType: Boolean;
        AccType: Boolean;
        AccNo: Boolean;
        DocNo: Boolean;
        Rmarks: Boolean;
        Amnt: Boolean;
        EmployerC: Boolean;
        IncType: Boolean;
        Pdate: Boolean;
        SalaryLines: Record "Salary Lines";
        LastloanDate: Boolean;
        Loans: Record Loans;
        "Descending": Boolean;
        RunBal: Decimal;
        Interest: Decimal;
        LineNo: Integer;
        Jtemplate: Text;
        Jbatch: Text;
        Divisor: Decimal;
        LRepayment: Decimal;
        ProductSetup: Record "Product Setup";
        UserSetup: Record "User Setup";
        SalaryHeader: Record "Salary Header";
        HREmployees: Record Employee;
        LNo: Integer;
        SavingsAccounts: Record "Savings Accounts";
        DocMustbeOpen: label 'This application request must be open';
        DocMustbePending: label 'This application request must be Pending';
        Text0001: label 'Ensure the Salary  Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Salary Journal Batch is set up in Banking User Setup';

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Salary Type" := Rec."Salary Type"::"Direct Debit";
    end;


    procedure UpdateControl()
    begin




        if Rec.Status = Rec.Status::Open then begin
            AccNo := true;
            TransType := true;
            AccType := true;
            DocNo := true;
            Rmarks := true;
            Amnt := true;
            EmployerC := true;
            Pdate := true;
            IncType := true;
            LastloanDate := true;

        end;


        if Rec.Status = Rec.Status::Pending then begin
            AccNo := false;
            TransType := false;
            AccType := false;
            DocNo := false;
            Rmarks := false;
            Amnt := false;
            EmployerC := false;
            Pdate := false;
            IncType := false;
            LastloanDate := false;

        end;


        if Rec.Status = Rec.Status::Rejected then begin
            AccNo := false;
            TransType := false;
            AccType := false;
            DocNo := false;
            Rmarks := false;
            Amnt := false;
            EmployerC := false;
            Pdate := false;
            IncType := false;
            LastloanDate := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            AccNo := false;
            TransType := false;
            AccType := false;
            DocNo := false;
            Rmarks := false;
            Amnt := false;
            EmployerC := false;
            Pdate := false;
            IncType := false;
            LastloanDate := false;

        end;
    end;

    local procedure CheckControls()
    begin


        Rec.TestField("Destination Transaction Type");
        if Rec.Status <> Rec.Status::Open then
            Error(DocMustbeOpen);

        Rec.CalcFields("Unidentified Amount", "Scheduled Amount");



        if Rec."Additional Deduction" > 0 then begin
            Rec.TestField("Add. Account No");
            Rec.TestField("Additional Ded. Details");
        end;
        //IF "Payment Type"="Payment Type"::" " THEN ERROR('Kindly select payment type');

        if Rec."Scheduled Amount" <> Rec.Amount then
            Error('Scheduled amount and Amount must be the same');

        if Rec."Unidentified Amount" <> 0 then
            Rec.TestField("Unidentified Account No");

        Rec.TestField("Destination Transaction Type");
        Rec.TestField("Account No");
        Rec.TestField("Document No");
        Rec.TestField(Remarks);
        Rec.TestField(Amount);
        Rec.TestField("Income Type");
        Rec.TestField("Posting date");

        if Rec.Validated = false then
            Error('Kindly validate the salary batch before proceeding');
    end;
}

