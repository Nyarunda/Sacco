Report 50201 "Get Commissions"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where("Commission Paid" = const(false));
            column(ReportForNavId_4645; 4645)
            {
            }

            trigger OnAfterGetRecord()
            var
                DepAmt: Decimal;
                Variance: Decimal;
                ComSetup: Record "Registration Commissions Setup";
                MActivities: Codeunit "Member Activities";
                Employee: Record Employee;
                Found: Boolean;
            begin
                CurrentRecordNo += 1;
                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

                Found := false;

                Reg.Reset();
                Reg.SetRange("External Document No.", Members."No.");
                if Reg.FindFirst() then
                    CurrReport.Skip();

                ComSetup.Get();
                CommAmt := ComSetup."Commission Amount";

                if (Cust.Get(Members."Recruited By")) and (Members."Recruited by Type" = Members."Recruited by Type"::Member) then begin

                    ComSetup.Get();
                    if ComSetup."Minimum Reg. Fee" > 0 then begin

                        if not MActivities.RegistrationFeeFullyPaid(Members."No.", ComSetup."Minimum Reg. Fee") then CurrReport.Skip();
                    end;
                    if ComSetup."Minimum Deposits" > 0 then begin

                        if not MActivities.DepositContributionFullyPaid(Members."No.", ComSetup."Minimum Deposits") then CurrReport.Skip();
                    end;


                    DepAccount.Reset;
                    DepAccount.SetRange("Member No.", Cust."No.");
                    DepAccount.SetRange("Product Category", DepAccount."product category"::"Ordinary Savings");
                    if DepAccount.FindFirst then begin


                        Reg.Init;
                        Reg."Entry No." := CurrentRecordNo;
                        Reg."Account Type" := Reg."account type"::Savings;
                        Reg."Account No." := DepAccount."No.";
                        Reg."Posting Date" := PDAte;
                        Reg."Document No." := 'REG-COMM ' + FORMAT(PDate, 0, '<Month Text>');
                        Reg.Description := CopyStr(Cust."Payroll/Staff No." + ' Registration Commission: ' + Members.Name + ' ' + Members."Payroll/Staff No.", 1, 50);
                        Reg."External Document No." := Members."No.";
                        Reg."Member No." := Cust."No.";
                        Reg.Amount := -CommAmt;
                        Reg."Credit Amount" := CommAmt;
                        Reg."Bal. Account Type" := Reg."bal. account type"::"G/L Account";
                        Reg."Bal. Account No." := saccoSetup."Registration Comm. Expense";
                        Reg.Insert;

                        Found := true;

                    end;

                end;

                if not Found then begin

                    //Staff no
                    if Members."Recruited by Type" = Members."Recruited by Type"::Staff then begin
                        Employee.Reset();
                        Employee.SetRange("No.", Members."Recruited By");
                        if Employee.FindFirst() then;
                    end else
                        if Members."Recruited by Type" = Members."Recruited by Type"::Marketer then begin
                            Employee.Reset();
                            Employee.SetRange("Salespers./Purch. Code", Members."Recruited By");
                            if Employee.FindFirst() then;
                        end;

                    Cust.Reset();
                    Cust.SetRange("No.", Employee."Member No");
                    if Cust.FindFirst() then begin

                        ComSetup.Get();
                        if ComSetup."Minimum Reg. Fee" > 0 then begin

                            if not MActivities.RegistrationFeeFullyPaid(Members."No.", ComSetup."Minimum Reg. Fee") then
                                CurrReport.Skip();
                        end;
                        if ComSetup."Minimum Deposits" > 0 then begin

                            if not MActivities.DepositContributionFullyPaid(Members."No.", ComSetup."Minimum Deposits") then
                                CurrReport.Skip();
                        end;


                        DepAccount.Reset;
                        DepAccount.SetRange("Member No.", Cust."No.");
                        DepAccount.SetRange("Product Category", DepAccount."product category"::"Ordinary Savings");
                        if DepAccount.FindFirst then begin

                            Reg.Init;
                            Reg."Entry No." := CurrentRecordNo;
                            Reg."Account Type" := Reg."account type"::Savings;
                            Reg."Account No." := DepAccount."No.";
                            Reg."Posting Date" := PDAte;
                            Reg."Document No." := 'REG-COMM ' + FORMAT(PDate, 0, '<Month Text>');
                            Reg.Description := CopyStr(Employee."Member No" + ' Registration Commission: ' + Members.Name + ' ' + Members."No.", 1, 50);
                            Reg."External Document No." := Members."No.";
                            Reg."Member No." := Cust."No.";
                            Reg.Amount := -CommAmt;
                            Reg."Credit Amount" := CommAmt;
                            Reg."Bal. Account Type" := Reg."bal. account type"::"G/L Account";
                            Reg."Bal. Account No." := saccoSetup."Registration Comm. Expense";
                            Reg.Insert;

                            Found := true;

                        end;

                    end;

                end;


                if (not Found) and (Cust.Get(Members."Recruited By")) and (Members."Recruited by Type" = Members."Recruited by Type"::"Board Member") then begin

                    ComSetup.Get();
                    if ComSetup."Minimum Reg. Fee" > 0 then begin

                        if not MActivities.RegistrationFeeFullyPaid(Members."No.", ComSetup."Minimum Reg. Fee") then CurrReport.Skip();
                    end;
                    if ComSetup."Minimum Deposits" > 0 then begin

                        if not MActivities.DepositContributionFullyPaid(Members."No.", ComSetup."Minimum Deposits") then CurrReport.Skip();
                    end;


                    DepAccount.Reset;
                    DepAccount.SetRange("Member No.", Cust."No.");
                    DepAccount.SetRange("Product Category", DepAccount."product category"::"Ordinary Savings");
                    if DepAccount.FindFirst then begin


                        Reg.Init;
                        Reg."Entry No." := CurrentRecordNo;
                        Reg."Account Type" := Reg."account type"::Savings;
                        Reg."Account No." := DepAccount."No.";
                        Reg."Posting Date" := PDAte;
                        Reg."Document No." := 'REG-COMM ' + FORMAT(PDate, 0, '<Month Text>');
                        Reg.Description := CopyStr(Cust."No." + ' Registration Commission: ' + Members.Name + ' ' + Members."No.", 1, 50);
                        Reg."External Document No." := Members."No.";
                        Reg."Member No." := Cust."No.";
                        Reg.Amount := -CommAmt;
                        Reg."Credit Amount" := CommAmt;
                        Reg."Bal. Account Type" := Reg."bal. account type"::"G/L Account";
                        Reg."Bal. Account No." := saccoSetup."Registration Comm. Expense";
                        Reg.Insert;

                        Found := true;

                    end;

                end;

                //Marketers no
                /*
                Cust.Reset();
                Cust.SetRange("Recruited by Type", Members."Recruited by Type"::Marketer);
                Cust.SetRange("Recruited By", Members."Recruited By");
                if Cust.FindFirst() then begin

                    ComSetup.Get();
                    if ComSetup."Minimum Reg. Fee" > 0 then begin

                        if not MActivities.RegistrationFeeFullyPaid(Members."No.") then CurrReport.Skip();
                    end;
                    if ComSetup."Minimum Deposits" > 0 then begin

                        if not MActivities.DepositContributionFullyPaid(Members."No.") then CurrReport.Skip();
                    end;


                    DepAccount.Reset;
                    DepAccount.SetRange("Member No.", Cust."No.");
                    DepAccount.SetRange("Product Category", DepAccount."product category"::"Ordinary Savings");
                    if DepAccount.FindFirst then begin

                        Reg.Init;
                        Reg."Entry No." := CurrentRecordNo;
                        Reg."Account Type" := Reg."account type"::Savings;
                        Reg."Account No." := DepAccount."No.";
                        Reg."Posting Date" := PDAte;
                        Reg."Document No." := 'REG-COMM ' + FORMAT(PDate, 0, '<Month Text>');
                        Reg.Description := CopyStr('Registration Commission: ' + Members.Name, 1, 50);
                        Reg."External Document No." := Members."No.";
                        Reg."Member No." := Cust."No.";
                        Reg.Amount := -CommAmt;
                        Reg."Credit Amount" := CommAmt;
                        Reg."Bal. Account Type" := Reg."bal. account type"::"G/L Account";
                        Reg."Bal. Account No." := saccoSetup."Registration Comm. Expense";
                        Reg.Insert;

                    end;

                end;*/

            end;

            trigger OnPostDataItem()
            begin
                dWindow.Close;
            end;

            trigger OnPreDataItem()
            begin



                saccoSetup.get;

                JTemplate := '';
                JBatch := '';

                //SaccoActivities.GetGeneralJournalTemplate(JTemplate,JBatch);


                //SaccoActivities.JournalInit(JTemplate,JBatch);


                if (SDate = 0D) or (EDate = 0D) or (PDAte = 0D) then
                    Error('Enter All Dates');

                Members.SetRange("Registration Date", SDate, EDate);
                Members.SetRange("Commission Paid", false);

                dWindow.Open('Get Lines:     @1@@@@@@@@@\'
                                            + 'Counter   #2#########'
                                            + 'Total     #3#########'
                                            + 'Press Esc to abort');

                NoOfRecords := Count;

                Reg.Reset;
                Reg.SetRange(Posted, true);//false
                if Reg.FindFirst then begin
                    Reg.DeleteAll;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; SDate)
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; EDate)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; PDAte)
                {
                    ApplicationArea = Basic;
                }
                field("Commission Amount"; CommAmt)
                {
                    ApplicationArea = Basic;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        LoansCaptionLbl: label 'Loans';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        VarienceCaptionLbl: label 'Varience';
        Text001: label 'Document No. Must be equal to No.';
        GeneratesuccMSG: label 'Interest Posted Successfully';
        AlreadyPostedErr: label 'This transaction Has already been posted';
        NoTemplateErr: label 'Ensure the Bills Template is set up in banking setup';
        NoBatchErr: label 'Ensure the Bills Batch is set up in the banking setup';
        SaccoActivities: Codeunit "Sacco Activities";
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        Updated: Boolean;
        ProductSetup: Record "Product Setup";
        DepositProduct: Code[10];
        ShareCapProduct: Code[10];
        AsAt: Date;
        ProductFactory: Record "Product Setup";
        MinDeposits: Decimal;
        Found: Boolean;
        Amount: array[5] of Decimal;
        Temp: Record "User Setup";
        JTemplate: Code[20];
        JBatch: Code[20];
        LineN: Integer;
        TransType: Enum "Transaction Type Enum";
        AccType: Enum "Gen. Journal Account Type";
        AccountNo: array[3] of Code[20];
        Description: array[3] of Text;
        membno: Code[50];
        JLine: Record "Gen. Journal Line";
        MinShares: Decimal;
        DepAccount: Record "Savings Accounts";
        DepAcc: Code[20];
        SDate: Date;
        EDate: Date;
        Cust: Record Members;
        Reg: Record "Registration Commissions";
        CommAmt: Decimal;
        PDAte: Date;
        saccoSetup: Record "Sacco Setup";
}

