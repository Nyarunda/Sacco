page 50556 "Update Loan"
{
    Caption = 'Update Loan';
    PageType = Card;
    SourceTable = Loans;
    InsertAllowed = false;
    DeleteAllowed = false;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan No. field.';
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.';
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Name field.';
                    Editable = false;
                }



                field("Debt Collector Type"; Rec."Debt Collector Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Name field.';
                    Editable = true;
                }
                field("Debt Collector"; Rec."Debt Collector")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Name field.';
                    Editable = true;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        RestrictAccessDebt;
                        Rec."Collector Updated By" := UserId;
                        if Rec."Debt Collector" <> '' then begin
                            Rec."Debt Coll. Date" := Today;
                            Rec."Debt Coll. Def Amount" := Rec."Debt Coll. Def Amount";
                            Rec."Debt Collector Type" := Rec."Debt Collector Type";
                            Rec."Debt Collector" := Rec."Debt Collector";
                            Rec."Debt Collector Name" := Rec."Debt Collector Name";
                        end;
                        Rec.Modify();
                    end;
                }
                field("Debt Collector Name"; Rec."Debt Collector Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Name field.';
                    Editable = false;
                }
            }
        }
    }


    procedure RestrictAccessDebt()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange("Update Debt Collector", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Update Debt Collector"');
    end;
}
