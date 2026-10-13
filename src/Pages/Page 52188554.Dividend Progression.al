
Page 50217 "Dividend Progression"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Dividends Progression";
    UsageCategory = Lists;
    SourceTableView = sorting("Entry No.");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EntryNo; Rec."Entry No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(ProcessingDate; Rec."Processing Date")
                {
                    ApplicationArea = Basic;
                }
                field(DividendCalcMethod; Rec."Dividend Calc. Method")
                {
                    ApplicationArea = Basic;
                }
                field(ProductType; Rec."Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(ProductName; Rec."Product Name")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field(QualifyingShares; Rec."Qualifying Shares")
                {
                    ApplicationArea = Basic;
                }
                field(Shares; Rec.Shares)
                {
                    ApplicationArea = Basic;
                }
                field(GrossDividends; Rec."Gross Dividends")
                {
                    ApplicationArea = Basic;
                }
                field(WitholdingTax; Rec."Witholding Tax")
                {
                    ApplicationArea = Basic;
                }
                field(NetDividends; Rec."Net Dividends")
                {
                    ApplicationArea = Basic;
                }
                field(StartDate; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(EndDate; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field(PaymentMode; Rec."Payment Mode")
                {
                    ApplicationArea = Basic;
                }
                field(DividendAccount; Rec."Dividend Account")
                {
                    ApplicationArea = Basic;
                }
                field("New Net"; Rec."New Net")
                {
                    ApplicationArea = Basic;
                }
                field(Exists; Rec.Exists)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }


    actions
    {
        area(processing)
        {
            action("Generate Dividends")
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Dividend Generation";
            }


            action("update net")
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger onAction()
                var
                    UPGMembers: Record "Dividends Progression";
                    SActivities: Codeunit "Sacco Activities";
                    CurrentRecordNo: Integer;
                    NoOfRecords: Integer;
                    dWindow: Dialog;
                    Vendor: Record "Savings Accounts";
                    MemberBalances: Record "Member Balances";
                    MLedger: Record "Member Ledger Entry";
                    Bal: Decimal;

                begin

                    UPGMembers.Reset();
                    //UPGMembers.setrange("Member No", '00002');
                    if UPGMembers.FindFirst() then begin
                        NoOfRecords := UPGMembers.Count;
                        SActivities.ProgressInit(dWindow, CurrentRecordNo, NoOfRecords);
                        repeat
                            CurrentRecordNo += 1;
                            Bal := 0;

                            SActivities.ProgressBarProcessing(dWindow, CurrentRecordNo, NoOfRecords, '');

                            UPGMembers."New Net" := UPGMembers."Net Dividends";

                            if UPGMembers."End Date" < DMY2Date(30, 11, 2022) then begin

                                MemberBalances.Reset;
                                MemberBalances.SetRange("Account No.", UPGMembers."Account No");
                                if MemberBalances.FindFirst then begin
                                    Bal := MemberBalances.Balance;
                                end;

                                if UPGMembers."End Date" >= DMY2Date(31, 01, 2022) then begin

                                    MLedger.Reset;
                                    MLedger.SetRange("Customer No.", UPGMembers."Account No");
                                    MLedger.Setrange("Posting Date", DMY2Date(31, 01, 2023), UPGMembers."End Date");
                                    if MLedger.FindFirst then begin
                                        MLedger.calcsums("Amount (LCY)");
                                        Bal += (MLedger."Amount (LCY)" * -1);
                                    end;
                                end;

                                if Bal <= 0 then
                                    UPGMembers."New Net" := 0;

                            end
                            else begin
                                Vendor.Reset();
                                Vendor.SetRange("No.", UPGMembers."Account No");
                                Vendor.SetFilter("Date Filter", '%1..%2', UPGMembers."End Date");
                                Vendor.SetFilter("Net Change (LCY)", '<=0');
                                if Vendor.FindFirst() then begin
                                    UPGMembers."New Net" := 0;
                                end;
                            end;
                            UPGMembers.Modify();
                        until UPGMembers.Next() = 0;
                        SActivities.ProgressClose(dWindow);
                    end;
                end;
            }


            action("Clear Buffer")
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    DivLines: Record "Dividends Progression";
                begin

                    if Confirm('Are you sure you want to DELETE all Entries?') then begin

                        DivLines.Reset;
                        if DivLines.Find('-') then
                            DivLines.DeleteAll;
                    end;
                end;
            }

        }
        area(Reporting)
        {
            action("Dividend Register")
            {
                ApplicationArea = Basic;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Dividend Register";
            }
            action("Dividend Register - Detailed")
            {
                ApplicationArea = Basic;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Dividend Register - Detailed";
            }
            action("Dividend Slip")
            {
                ApplicationArea = Basic;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Dividend Slip";
            }
        }
    }

    var
        SaccoSetup: Record "Sacco Setup";
}

