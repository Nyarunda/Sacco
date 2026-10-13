/// <summary>
/// Table Loans Offet List (ID 52221).
/// </summary>
Table 52221 "Loans Offet List"
{

    fields
    {
        field(1; "Loan No"; Code[30])
        {
            TableRelation = "Loans"."Loan No." where("Outstanding Principal" = filter(> 0), "Member No." = field("Member No"));

            trigger OnValidate()
            var
                MemberAccounts: Record "Savings Accounts";
                PSetup: Record "Product Setup";
                PrBal: Decimal;
                IntBal: Decimal;
            begin

                PrBal := 0;
                IntBal := 0;

                loansList.Reset;
                loansList.SetRange("Loan No.", "Loan No");
                if loansList.FindFirst then begin

                    "Member No" := loansList."Member No.";
                    "Member Names" := loansList."Member Name";
                    "Approved Amount" := loansList."Approved Amount";
                    "Recover From Guarantors" := true;

                    loansList.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Insurance","Outstanding Penalty", "Principal Arrears", "SASRA Arrears");
                    "Outstanding Principal" := loansList."Outstanding Principal";
                    "Outstanding insurance" := loansList."Outstanding Insurance";
                    "Outstanding Penalty" := loansList."Outstanding Penalty";
                    "Loan Product" := loansList."Loan Product Type Name";
                    "Captured By" := UserId;
                    "Outstanding Interest" := loansList."Outstanding Interest";
                    "Normal Shares" := MActivities.GetAccountBalance(Legacy.GetDepositAccounts("Member No"));
                    "Share Capital" := MActivities.GetAccountBalance(Legacy.GetDepositAccounts("Member No"));

                    "Share Caiptal Top Up" := 0;
                    /*
                    PSetup.Reset();
                    PSetup.SetRange("Product Category", PSetup."Product Category"::"Share Capital");
                    if PSetup.FindFirst() then begin
                        if "Share Capital" < PSetup."Mandatory Contribution" then
                            "Share Caiptal Top Up" := PSetup."Mandatory Contribution" - "Share Capital"
                        else
                            "Share Caiptal Top Up" := 0;
                    end;
                    */

                    sharesBalance := "Normal Shares" - "Outstanding Principal" - "Share Caiptal Top Up";

                    "Share Capital-New" := "Share Capital" + "Share Caiptal Top Up";

                    if sharesBalance <= 0 then
                        "Waived amount" := "Outstanding Interest"
                    else
                        "Waived amount" := "Outstanding Interest" - sharesBalance;

                    if "Waived amount" < 0 then
                        "Waived amount" := 0;
                end;

                /*Header.Get("Header No.");
                if Header."Recovery Type" = Header."Recovery Type"::Arrears then begin
                    "Amount to Recover" := loansList."Principal Arrears";
                end else
                    "Amount to Recover" := "Outstanding Interest" + "Outstanding Principal" - "interest waiver";
                    */

            end;
        }
        field(2; "Member No"; Code[30])
        {
        }
        field(3; "Waived amount"; Decimal)
        {
        }
        field(4; stage; Option)
        {
            OptionCaption = 'Credit Department,Finance,Credit Dept,Credit.Department,Credit Officer,Credit Off,CEO,Finance Department';
            OptionMembers = "Credit Department",Finance,"Credit Dept","Credit.Department","Credit Officer","Credit Off",CEO,"Finance Department";
        }
        field(5; status; Option)
        {
            OptionCaption = 'Book Loan to Offset,TopUp Shares,Open,Pending,Approved,Rejected,Posted,Processing';
            OptionMembers = "Book Loan to Offset","TopUp Shares",Open,Pending,Approved,Rejected,Posted,Processing;
        }
        field(6; "Posting Date"; DateTime)
        {
        }
        field(7; "Captured By"; Text[30])
        {
        }
        field(8; "Member Names"; Text[30])
        {
        }
        field(9; "Approved Amount"; Decimal)
        {
        }
        field(10; "Outstanding Principal"; Decimal)
        {
        }
        field(11; "Outstanding Interest"; Decimal)
        {
        }
        field(12; "Loan Product"; Code[50])
        {
        }
        field(13; "Share Capital"; Decimal)
        {

            trigger OnValidate()
            begin
                UpdateShares.Reset;
                UpdateShares.SetRange("Loan No", loansList."Loan No.");
                if UpdateShares.FindFirst then begin
                    UpdateShares."Share Capital" := "Share Capital";
                    UpdateShares.Modify;
                end;
            end;
        }
        field(14; "Normal Shares"; Decimal)
        {
        }
        field(15; "Outstanding Principal-New"; Decimal)
        {
        }
        field(16; "Outstanding Interest-New"; Decimal)
        {
        }
        field(17; "Share Capital-New"; Decimal)
        {
        }
        field(18; "Normal Shares-New"; Decimal)
        {
        }
        field(19; "Waiver Type"; Option)
        {
            OptionCaption = 'NA,Fully,Partial';
            OptionMembers = NA,Fully,Partial;
        }
        field(20; "Share Caiptal Top Up"; Decimal)
        {
        }
        field(21; "Rejected By"; Text[30])
        {
        }
        field(22; "New Share Capital"; Decimal)
        {
        }
        field(23; "Guarantors Liability"; Decimal)
        {
        }
        field(24; "interest waiver"; Decimal)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin

                "Amount to Recover" := "Outstanding Interest" + "Outstanding Principal" - "interest waiver";
            end;
        }
        field(25; "Shares After Topup"; Decimal)
        {
        }

        field(26; "Header No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(27; "Recover From Guarantors"; Boolean)
        {
        }

        field(28; "Self Guaranteed"; Boolean)
        {
        }
        field(29; "Amount to Recover"; Decimal)
        {
        }
        field(30; "Deposit Allocation Amount"; Decimal)
        {
        }
        field(31; "Outstanding insurance"; Decimal)
        {
        }
        field(32; "Outstanding Penalty"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Header No.", "Loan No", "Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(MemberNo; "Member No")
        {
        }
    }

    var
        loansList: Record Loans;
        membersList: Record Members;
        Header: Record "Defaulter Loan Recovery";
        intPaid: Decimal;
        intDue: Decimal;
        sharesBalance: Decimal;
        UpdateShares: Record "Loans Offet List";
        MembersRegister: Record Members;
        BalanceList: Record Customer;
        Legacy: Codeunit Legacy;
        MActivities: Codeunit "Member Activities";
        SaccoActivities: Codeunit "Sacco Activities";
}

