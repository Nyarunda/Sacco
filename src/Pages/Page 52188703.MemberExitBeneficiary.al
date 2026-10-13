page 50366 "Member Exit Beneficiary"
{
    Caption = 'Member Exit Beneficiary';
    PageType = ListPart;
    SourceTable = "Member Exit Beneficiary";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Beneficiary Name"; Rec."Beneficiary Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Beneficiary Name field.';
                }
                field(Relation; Rec.Relation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Relation field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remark field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(OpenPV)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    PVHeader: Record "Payment Header";
                begin
                    if Rec."PV No." <> '' then begin
                        PVHeader.Reset();
                        PVHeader.SetRange("No.", Rec."PV No.");
                        if PVHeader.FindFirst() then
                            Page.Run(50308, PVHeader);
                    end;
                end;
            }
        }
    }
}
