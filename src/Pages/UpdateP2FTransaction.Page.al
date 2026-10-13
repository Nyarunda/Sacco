Page 50005 "Update P2F Transaction"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Coop Pay2Fosa";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(TransactionID; Rec."Transaction ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TransactionDate; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec."Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Correct Account No."; Rec."Member Account No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin

                        Rec.TestField("Member Account No.");


                        if Members.Get(Rec."Member Account No.") then begin
                            if Confirm('Acc. Name: ' + Members.Name + '\ Confirm Member?') then begin

                                Rec."Changed By" := UserId;
                                Rec."Changed Date" := Today;
                                Rec."Changed By" := UserId;
                                //Rec."Transaction Date" := TODAY;
                                Rec.Modify;
                            end
                            else
                                Error('Aborted');
                        end else begin
                            Members.Reset();
                            Members.SetRange("Old Member No.", Rec."Member Account No.");
                            if Members.FindFirst() then begin
                                if Confirm('Acc. Name: ' + Members.Name + '\ Confirm Member?') then begin
                                    Rec."Member Account No." := Members."No.";
                                    Rec."Changed By" := UserId;
                                    Rec."Changed Date" := Today;
                                    Rec."Changed By" := UserId;
                                    //Rec."Transaction Date" := TODAY;
                                    Rec.Modify;
                                end
                                else
                                    Error('Aborted');
                            end

                            else if SavAcc.Get(Rec."Member Account No.") then begin


                                if Confirm('Acc. Name: ' + SavAcc.Name + '\ Confirm Member?') then begin

                                    Rec."Changed By" := UserId;
                                    Rec."Changed Date" := Today;
                                    Rec."Changed By" := UserId;
                                    //Rec."Transaction Date" := TODAY;
                                    Rec.Modify;
                                end
                                else
                                    Error('Aborted');


                            end
                            else begin

                                if Loans.Get(Rec."Member Account No.") then begin


                                    if Confirm('Acc. Name: ' + Loans."Member Name" + '\Loan Type: ' + Loans."Loan Product Type" + '\ Confirm Member?') then begin
                                        Rec."Changed By" := UserId;
                                        Rec."Changed Date" := Today;
                                        Rec."Changed By" := UserId;
                                        //Rec."Transaction Date" := TODAY;
                                        Rec.Modify;
                                    end
                                    else
                                        Error('Aborted');
                                end
                                else begin

                                    Loans.Reset();
                                    Loans.SetRange("Loan Account", Rec."Member Account No.");
                                    if Loans.FindFirst() then begin

                                        if Confirm('Acc. Name: ' + Loans."Member Name" + '\Loan Type: ' + Loans."Loan Product Type" + '\ Confirm Member?') then begin
                                            Rec."Changed By" := UserId;
                                            Rec."Changed Date" := Today;
                                            Rec."Changed By" := UserId;
                                            //Rec."Transaction Date" := TODAY;
                                            Rec.Modify;
                                        end
                                        else
                                            Error('Aborted');
                                    end
                                    else
                                        Error('Member Not Found. Kindly Capture the correct Account No.');
                                end;

                                /*PayBillAccNo := "Member Account No.";
                                MAccNo := '';
                                LoanAccount := false;
                                DepositAccount := false;
                                IDNo := '';
                                MNo := '';
                                Key := '';
                                LNo := '';
                                BosaTransType := Bosatranstype::None;

                                SkyMBanking.GetAccountFromKeyWord(PayBillAccNo, MAccNo, LoanAccount, DepositAccount, IDNo, MNo, BosaTransType, Key, LNo);

                                if BosaTransType = Bosatranstype::"Loan Repayment" then begin
                                    if MNo <> '' then
                                        if LNo = '' then
                                            Error('Loan %1 Not Found For Member: %2', Key, MNo);

                                end;

                                if MAccNo = '' then
                                    Error('Member Not Found. Kindly Capture the correct ID No. + KeyWord');

                                Message(MAccNo);

                                if MAccNo <> '' then begin
                                    if LoanAccount then begin
                                        if Loans.Get(LNo) then begin
                                            if Members.Get(Loans."Member No.") then begin
                                                if Members.Blocked <> Members.Blocked::" " then begin
                                                    Error('Bosa Member No. %1 - %2 is Blocked', Loans."Member No.", Members.Name);
                                                end;
                                            end;

                                        end;

                                        if Members.Get(MNo) then begin
                                            if Members.Blocked <> Members.Blocked::" " then begin
                                                Error('Bosa Member No. %1 - %2 is Blocked', MNo, Members.Name);
                                            end;

                                        end;

                                        if SavAcc.Get(MAccNo) then begin
                                            if SavAcc.Blocked <> SavAcc.Blocked::" " then begin
                                                Error('Fosa Account No. %1 - %2 is Blocked', MAccNo, SavAcc.Name);
                                            end;

                                        end;
                                    end
                                    else begin
                                        if SavAcc.Get(MAccNo) then begin
                                            MName := SavAcc.Name;
                                            if SavAcc.Blocked <> SavAcc.Blocked::" " then begin
                                                Error('Fosa Account No. %1 - %2 is Blocked', MAccNo, SavAcc.Name);
                                            end;
                                        end;

                                        if Members.Get(MNo) then begin
                                            MName := Members.Name;
                                            if Members.Blocked <> Members.Blocked::" " then begin
                                                Error('Bosa Member No. %1 - %2 is Blocked', MNo, Members.Name);
                                            end;

                                        end;

                                    end;


                                    if Confirm('TransType: ' + Format(BosaTransType) + '\Acc. Name: ' + MName + '\ Confirm Member?') then begin
                                        "Needs Change" := false;
                                        "Transaction Type" := "transaction type"::"Mpesa Deposit";
                                        "Changed By" := UserId;
                                        "Date Changed" := Today;
                                        "Changed By" := UserId;
                                        Modify;
                                    end
                                    else
                                        Error('Aborted');



                                end;
                                */

                            end;
                        end;
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {

        }
    }

    trigger OnInit()
    begin
        StatusChangePermissions.Reset;
        StatusChangePermissions.SetRange("User ID", UserId);
        StatusChangePermissions.SetRange("Update Paybill Transaction", true);
        if not StatusChangePermissions.FindFirst then
            Error('You do not have the following permission: "Update Paybill Transaction"');
    end;

    var
        StatusChangePermissions: Record "Sky Permissions";
        Savings: Record "Savings Accounts";
        PayBillAccNo: Code[20];
        MAccNo: Code[20];
        LoanAccount: Boolean;
        DepositAccount: Boolean;
        IDNo: Code[20];
        MNo: Code[20];
        BosaTransType: Option "None","Loan Repayment","Shares Capital","Deposit Contribution","Benevolent Funds";
        "Key": Code[20];
        LNo: Code[20];
        SkyMBanking: Codeunit "Sky MBanking";
        Loans: Record Loans;
        Members: Record Members;
        SavAcc: Record "Savings Accounts";
        MName: Text;
}
