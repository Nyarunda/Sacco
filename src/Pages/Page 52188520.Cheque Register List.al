
Page 50183 "Cheque Register List"
{
    PageType = List;
    SourceTable = "Cheques Register_";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ChequeNo; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(ApprovalDate; Rec."Approval Date")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationNo; Rec."Application No.")
                {
                    ApplicationArea = Basic;
                }
                field(CancelledStoppedBy; Rec."Cancelled/Stopped By")
                {
                    ApplicationArea = Basic;
                }
                field(Used; Rec.Used)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(UsedByDocumentNo; Rec."Used By Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Cancel Cheque")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to cancel cheque ?', false) = true then begin
                        if Rec.Status <> Rec.Status::Pending then
                            Error('Status must be pending');
                        Rec.Status := Rec.Status::Cancelled;
                        Rec."Approval Date" := Today;
                        Rec."Cancelled/Stopped By" := UserId;
                        Rec.Modify;
                    end;
                end;
            }
            action("Stop Cheque")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to stop cheque ?', false) = true then begin
                        if Rec.Status <> Rec.Status::Pending then
                            Error('Status must be pending');
                        Rec.Status := Rec.Status::stopped;
                        Rec."Approval Date" := Today;
                        Rec."Cancelled/Stopped By" := UserId;
                        Rec.Modify;
                    end;
                end;
            }
            action("Cancel Cheque Book")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    //reset;
                end;
            }
            action("Update Cheque Nos")
            {
                ApplicationArea = Basic;
                Visible = false;

                trigger OnAction()
                begin

                    ChequesRegister.Reset;
                    ChequesRegister.SetRange("Application No.", Rec."Application No.");
                    if ChequesRegister.Find('-') then
                        repeat
                            if StrLen(ChequesRegister."Cheque No.") = 6 then begin
                                //ChequesRegister."Cheque No.":='0000'+ChequesRegister."Cheque No.";

                                Reg.Get(ChequesRegister."Cheque No.", ChequesRegister."Account No.", ChequesRegister."Application No.");
                                Reg.Rename('0000' + ChequesRegister."Cheque No.", ChequesRegister."Account No.", ChequesRegister."Application No.");

                            end;
                        until ChequesRegister.Next = 0;
                end;
            }
        }
    }

    var
        ChequesRegister: Record "Cheques Register_";
        Reg: Record "Cheques Register_";
}

