report 50344 "Block Member"
{
    ApplicationArea = All;
    Caption = 'Block Member';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Customer; Members)
        {
            //DataItemTableView=where(Type)
            DataItemTableView = where(Type = filter('Group|Member'));
            trigger OnAfterGetRecord()
            var
                MemberAcc: Record "Savings Accounts";
                CanBlock: Boolean;
                DepBal: Decimal;
                SCapBal: Decimal;
            begin
                CanBlock := false;
                DepBal := 0;
                SCapBal := 0;
                MemberAcc.Reset();
                MemberAcc.SetRange("Member No.", Customer."No.");
                MemberAcc.SetAutoCalcFields("Balance (LCY)");
                MemberAcc.SetFilter("Product Category", '%1|%2',
                MemberAcc."Product Category"::"Deposit Contribution", MemberAcc."Product Category"::"Share Capital");
                if MemberAcc.FindSet() then
                    repeat

                        if MemberAcc."Product Category" = MemberAcc."Product Category"::"Deposit Contribution" then
                            DepBal := MemberAcc."Balance (LCY)";
                        if MemberAcc."Product Category" = MemberAcc."Product Category"::"Share Capital" then
                            SCapBal := MemberAcc."Balance (LCY)";

                    until MemberAcc.Next() = 0;

                CanBlock := (DepBal <= 0) and (SCapBal <= 0) and ("Registration Date" < DMY2Date(1, 1, 2023));

                if CanBlock then begin
                    MemberAcc.Reset();
                    MemberAcc.SetRange("Member No.", Customer."No.");
                    MemberAcc.SetRange("Product Category", MemberAcc."Product Category"::"Ordinary Savings");
                    if MemberAcc.FindFirst() then begin
                        MemberAcc.Blocked := MemberAcc.Blocked::All;
                        MemberAcc.Modify();
                    end;
                end;

            end;
        }

    }

}
