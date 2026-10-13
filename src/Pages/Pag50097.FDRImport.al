page 50097 "FDR Import"
{
    Caption = 'FDR Import';
    PageType = List;
    SourceTable = "FDR Import";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reference No field.';
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No field.';
                }
                field("Fixed Deposit Type"; Rec."Fixed Deposit Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fixed Deposit Type field.';
                }
                field("Duration"; Rec."Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maturity Date field.';
                }
                field("Maturity Instructions"; Rec."Maturity Instructions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maturity Instructions field.';
                }
                field("Negotiated Interest"; Rec."Negotiated Interest")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Negotiated Interest field.';
                }
                field("Interest Expected"; Rec."Interest Expected")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interest Expected field.';
                }
                field("AMount + Interest"; Rec."AMount + Interest")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the AMount + Interest field.';
                }
                field(Created; Rec.Created)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Create FDR")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Import: Record "FDR Import";
                    FDR: Record "Fixed Deposit Accounts";
                    Accounts: Record "Savings Accounts";
                    Fosa: Record "Savings Accounts";
                    Members: Record Members;
                    PSetup: Record "Product Setup";
                    MActivities: Codeunit "Member Activities";
                begin
                    if Confirm('Are you sure you want to Create FDR?') then begin
                        Import.Reset();
                        //Import.SetRange(Created, false);
                        if Import.findfirst then begin
                            repeat

                                if FDR.Get(Import."Reference No") then begin

                                    if Accounts.get(Import."Account No") then begin


                                        Fosa.Reset();
                                        fosa.SetRange("Member No.", Accounts."Member No.");
                                        fosa.SetRange("Product Category", Fosa."Product Category"::"Ordinary Savings");
                                        if not fosa.FindFirst() then begin
                                            PSetup.Reset();
                                            PSetup.SetRange("Product Category", PSetup."Product Category"::"Ordinary Savings");
                                            if PSetup.FindFirst() then begin
                                                Members.get(Accounts."Member No.");
                                                MActivities.CreateSavingsAccount(PSetup, Members, 0, false, PSetup."Repay Mode");
                                            end;
                                        end;


                                        Fosa.Reset();
                                        fosa.SetRange("Member No.", Accounts."Member No.");
                                        fosa.SetRange("Product Category", Fosa."Product Category"::"Ordinary Savings");
                                        if fosa.FindFirst() then begin

                                            FDR."No." := Import."Reference No";
                                            FDR."Application Date" := Import."Start Date";
                                            FDR.Validate("Member No.", Fosa."Member No.");
                                            FDR.Validate("FD Type", Import."Fixed Deposit Type");
                                            FDR.Validate("FD Start Date", Import."Start Date");
                                            fdr.Validate("FD Amount", Import.Amount);
                                            FDR."Approval Status" := FDR."Approval Status"::Approved;
                                            FDR."Negotiated Interest %" := Import."Negotiated Interest";
                                            if Rec."Maturity Instructions" = 'Rollover Contract' then
                                                FDR."FD Maturity Instructions" := FDR."FD Maturity Instructions"::"Renew Both Principal & Interest";
                                            if Rec."Maturity Instructions" = 'Liquidate Contract' then
                                                FDR."FD Maturity Instructions" := FDR."FD Maturity Instructions"::"Transfer all to Savings";
                                            if Rec."Maturity Instructions" = 'Rollover Principal Only' then
                                                FDR."FD Maturity Instructions" := FDR."FD Maturity Instructions"::"Transfer Interest & Renew Principal";
                                            FDR.Modify();
                                        end;
                                    end;
                                end
                                else begin
                                    if Accounts.get(Import."Account No") then begin

                                        Fosa.Reset();
                                        fosa.SetRange("Member No.", Accounts."Member No.");
                                        fosa.SetRange("Product Category", Fosa."Product Category"::"Ordinary Savings");
                                        if not fosa.FindFirst() then begin
                                            PSetup.Reset();
                                            PSetup.SetRange("Product Category", PSetup."Product Category"::"Ordinary Savings");
                                            if PSetup.FindFirst() then begin
                                                Members.get(Accounts."Member No.");
                                                MActivities.CreateSavingsAccount(PSetup, Members, 0, false, PSetup."Repay Mode");
                                            end;
                                        end;



                                        Fosa.Reset();
                                        fosa.SetRange("Member No.", Accounts."Member No.");
                                        fosa.SetRange("Product Category", Fosa."Product Category"::"Ordinary Savings");
                                        if fosa.FindFirst() then begin
                                            FDR.Init();
                                            FDR."No." := Import."Reference No";
                                            FDR."Application Date" := Import."Start Date";
                                            FDR.Validate("Member No.", Fosa."Member No.");
                                            FDR.Validate("FD Type", Import."Fixed Deposit Type");
                                            FDR.Validate("FD Start Date", Import."Start Date");
                                            fdr.Validate("FD Amount", Import.Amount);
                                            FDR."Approval Status" := FDR."Approval Status"::Approved;
                                            FDR."Negotiated Interest %" := Import."Negotiated Interest";
                                            if Rec."Maturity Instructions" = 'Rollover Contract' then
                                                FDR."FD Maturity Instructions" := FDR."FD Maturity Instructions"::"Renew Both Principal & Interest";
                                            if Rec."Maturity Instructions" = 'Liquidate Contract' then
                                                FDR."FD Maturity Instructions" := FDR."FD Maturity Instructions"::"Transfer all to Savings";
                                            if Rec."Maturity Instructions" = 'Rollover Principal Only' then
                                                FDR."FD Maturity Instructions" := FDR."FD Maturity Instructions"::"Transfer Interest & Renew Principal";
                                            FDR.Insert();
                                            Import.Created := true;
                                            Import.Modify();
                                        end;
                                    end;


                                end;


                            until Import.Next() = 0;
                        end;

                    end;
                end;
            }
        }
    }

}
