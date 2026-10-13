
Page 50306 "Bankers Cheque Register"
{
    PageType = List;
    SourceTable = "Bankers Cheque Register";

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
                field(BankAccount; Rec."Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
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
            action("Cancel Cheque")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    /*
                    StatusChangePermissions.RESET;
                    StatusChangePermissions.SETRANGE("User ID",USERID);
                    StatusChangePermissions.SETRANGE("Re-Open Bankers Cheque",TRUE);
                    IF NOT StatusChangePermissions.FINDFIRST THEN
                        ERROR('You do not have the following Status Change Permission: "Update Bankers Cheque". Contact the System Administrator for Assistance');
                    
                    */

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
                    /*
                    StatusChangePermissions.RESET;
                    StatusChangePermissions.SETRANGE("User ID",USERID);
                    StatusChangePermissions.SETRANGE("Re-Open Bankers Cheque",TRUE);
                    IF NOT StatusChangePermissions.FINDFIRST THEN
                        ERROR('You do not have the following Status Change Permission: "Update Bankers Cheque". Contact the System Administrator for Assistance');
                        */
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
            action("Re-Open Cheque")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    /*
                    StatusChangePermissions.RESET;
                    StatusChangePermissions.SETRANGE("User ID",USERID);
                    StatusChangePermissions.SETRANGE("Re-Open Bankers Cheque",TRUE);
                    IF NOT StatusChangePermissions.FINDFIRST THEN
                        ERROR('You do not have the following Status Change Permission: "Update Bankers Cheque". Contact the System Administrator for Assistance');
                    */



                    if Confirm('Are you sure you want to reopen cheque ?', false) = true then begin

                        if Rec.Status = Rec.Status::Pending then
                            Error('Status must not be pending');
                        Rec.Status := Rec.Status::Pending;
                        Rec."Approval Date" := Today;
                        Rec."Cancelled/Stopped By" := UserId;
                        Rec.Modify;
                    end;

                end;
            }
        }
    }
}

