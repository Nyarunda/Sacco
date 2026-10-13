//namespace CentralDB.CentralDB;

report 50465 "Create Old Sys. Standing Order"
{
    Caption = 'Create Old Sys. Standing Order';
    ProcessingOnly = true;
    dataset
    {
        dataitem(OldSystemLoans; "Old System Loans")
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                Ln: Record Loans;
                Mem: Record Members;
            begin
                if Ln.Get(OldSystemLoans."Loan No.") then
                    CreateStandingOrder(Ln)
                else if Mem.Get(OldSystemLoans."Member No.") then
                    CreateStandingSavingsOrder(Mem);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    procedure CreateStandingOrder(VAR Loans: Record Loans)
    var
        myInt: Integer;
        STOHeader: Record "Standing Order Header";
        STOLines: Record "Standing Order Lines";
        OldLoans: Record "Old System Loans";
        SavingsAccount: Record "Savings Accounts";
        SaccoActivities: Codeunit "Sacco Activities";
        MemberActivities: Codeunit "Member Activities";
        PSetup: Record "Product Setup";
        Member: Record Members;
        Acc: Code[20];
    begin
        Acc := '';
        Loans."Standing Order Amount" := Loans.Repayment;

        Loans.testfield("Standing Order Amount");
        STOLines.Reset();
        STOLines.setrange("Loan No.", Loans."Loan No.");
        if STOLines.FindFirst() then
            STOLines.delete();

        SavingsAccount.Reset();
        SavingsAccount.SetRange("Member No.", Loans."Member No.");
        SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Unallocated Fund");
        if not SavingsAccount.FindFirst() then begin
            Member.Get(Loans."Member No.");
            PSetup.Reset();
            PSetup.SetRange("Product Category", PSetup."Product Category"::"Unallocated Fund");
            if PSetup.FindFirst() then
                Acc := MemberActivities.CreateSavingsAccount(PSetup, Member, PSetup."Minimum Contribution", true, PSetup."Repay Mode")
        end else if SavingsAccount.FindFirst() then begin
            Acc := SavingsAccount."No.";
        end;

        STOLines.Reset();
        STOLines.setrange("Loan No.", Loans."Loan No.");
        if not STOLines.Findfirst() then begin


            if Loans."Standing Order Amount" > 0 then begin
                STOHeader.init;

                STOHeader.Code := '';
                STOHeader."Source Account Type" := STOHeader."Source Account Type"::Savings;
                STOHeader.validate("Source Account No.", Acc);
                STOHeader.Description := Loans."Loan Product Type Name";
                STOHeader.Amount := Loans."Standing Order Amount";
                STOHeader."Allow Partial Deduction" := true;
                STOHeader."Income Type" := STOHeader."Income Type"::Business;
                STOHeader."Created By" := UserID;
                STOHeader.Status := STOHeader.Status::Approved;
                STOHeader."Effective/Start Date" := Today;
                Evaluate(STOHeader."Frequency (Months)", '1M');
                Evaluate(STOHeader."Duration (Months)", '999M');
                STOHeader.Validate("Duration (Months)");
                STOHeader."Auto Process" := true;
                STOHeader.Insert(true);

                Loans."STO No." := STOHeader.Code;

                STOLines.Init();
                STOLines."Document No." := STOHeader.Code;
                STOLines."Destination Account Type" := STOLines."Destination Account Type"::Credit;
                STOLines."Destination Account No." := Loans."Loan Account";
                STOLines."Member No." := Loans."Member No.";
                STOLines."Loan No." := Loans."Loan No.";
                STOLines.Amount := STOHeader.Amount;
                STOLines.Insert();

                SavingsAccount.Reset();
                SavingsAccount.SetRange("Member No.", Loans."Member No.");
                SavingsAccount.SetFilter("Monthly Contribution", '>0');
                SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Deposit Contribution");
                if SavingsAccount.FindFirst() then begin
                    STOLines.Init();
                    STOLines."Document No." := STOHeader.Code;
                    STOLines."Destination Account Type" := STOLines."Destination Account Type"::Internal;
                    STOLines."Destination Account No." := SavingsAccount."No.";
                    STOLines."Member No." := SavingsAccount."Member No.";
                    //STOLines."Loan No." := Loans."Loan No.";
                    STOLines.Amount := SavingsAccount."Monthly Contribution";
                    STOLines.Insert();



                    STOHeader.Reset();
                    STOHeader.SetRange(Code, STOLines."Document No.");
                    if STOHeader.FindFirst() then begin
                        STOHeader.Amount += STOLines.Amount;
                        STOHeader.Modify();
                    end;
                end;

            end

        end;

    end;

    procedure CreateStandingSavingsOrder(Member: Record Members)
    var
        myInt: Integer;
        STOHeader: Record "Standing Order Header";
        STOLines: Record "Standing Order Lines";
        OldLoans: Record "Old System Loans";
        SavingsAccount: Record "Savings Accounts";
        SaccoActivities: Codeunit "Sacco Activities";
        MemberActivities: Codeunit "Member Activities";
        PSetup: Record "Product Setup";
        Acc: Code[20];
    begin
        Acc := '';

        SavingsAccount.Reset();
        SavingsAccount.SetRange("Member No.", Member."No.");
        SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Unallocated Fund");
        if not SavingsAccount.FindFirst() then begin
            Member.Get(Member."No.");
            PSetup.Reset();
            PSetup.SetRange("Product Category", PSetup."Product Category"::"Unallocated Fund");
            if PSetup.FindFirst() then
                Acc := MemberActivities.CreateSavingsAccount(PSetup, Member, PSetup."Minimum Contribution", true, PSetup."Repay Mode")
        end else if SavingsAccount.FindFirst() then begin
            Acc := SavingsAccount."No.";
        end;

        //STOLines.Reset();
        //STOLines.setrange("Loan No.", Loans."Loan No.");
        //if not STOLines.Findfirst() then begin



        SavingsAccount.Reset();
        SavingsAccount.SetRange("Member No.", Member."No.");
        //SavingsAccount.SetFilter("Monthly Contribution", '>0');
        SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Deposit Contribution");
        if SavingsAccount.FindFirst() then begin
            PSetup.get(SavingsAccount."Product Type");

            STOHeader.init;

            STOHeader.Code := '';
            STOHeader."Source Account Type" := STOHeader."Source Account Type"::Savings;
            STOHeader.validate("Source Account No.", Acc);
            STOHeader.Description := SavingsAccount."Product Name";
            //STOHeader.Amount := PSetup."Minimum Contribution";
            STOHeader."Allow Partial Deduction" := true;
            STOHeader."Income Type" := STOHeader."Income Type"::Business;
            STOHeader."Created By" := UserID;
            STOHeader.Status := STOHeader.Status::Approved;
            STOHeader."Effective/Start Date" := Today;
            Evaluate(STOHeader."Frequency (Months)", '1M');
            Evaluate(STOHeader."Duration (Months)", '999M');
            STOHeader.Validate("Duration (Months)");
            STOHeader."Auto Process" := true;
            STOHeader.Insert(true);


            STOLines.Init();
            STOLines."Document No." := STOHeader.Code;
            STOLines."Destination Account Type" := STOLines."Destination Account Type"::Internal;
            STOLines."Destination Account No." := SavingsAccount."No.";
            STOLines."Member No." := SavingsAccount."Member No.";
            //STOLines."Loan No." := Loans."Loan No.";
            STOLines.Amount := SavingsAccount."Monthly Contribution";
            if STOLines.Amount = 0 then
                STOLines.Amount := PSetup."Minimum Contribution";

            STOLines.Insert();



            STOHeader.Reset();
            STOHeader.SetRange(Code, STOLines."Document No.");
            if STOHeader.FindFirst() then begin
                STOHeader.Amount += STOLines.Amount;
                STOHeader.Modify();
            end;
        end

        //end;

    end;

}
