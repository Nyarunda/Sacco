Page 50540 "Agent Transfer Page"
{
    PageType = Card;
    SourceTable = "Sky Agent Transfer";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
                field(TransactionDate; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionTime; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field(AgentCode; Rec."Agent Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field(AgentName; Rec."Agent Name")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(DatePosted; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field(TimePosted; Rec."Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field(PostedBy; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(DebitAccountType; Rec."Debit Account Type")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Rejection reason")
            {
                Editable = RejectedEditable;
                field(RejectionReason; Rec."Rejection Reason")
                {
                    ApplicationArea = Basic;
                }
                field(Rejected; Rec.Rejected)
                {
                    ApplicationArea = Basic;
                }
                field(RejectedBy; Rec."Rejected By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Post)
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;

                trigger OnAction()
                begin
                    if Rec.Posted then Error('The transaction has already been posted');
                    if Rec.Rejected then Error('You cannot post a rejected transaction');
                    //MESSAGE("Transaction ID");
                    //SkyAgencyBanking.PostAgentTransaction("Transaction ID");
                    Message('Posted Sucsessfully');
                end;
            }
            action(Reject)
            {
                ApplicationArea = Basic;
                Image = Reject;
                Promoted = true;

                trigger OnAction()
                begin
                    if Rec.Posted then Error('You cannot rejected a posted transaction');
                    if Rec.Rejected then Error('The transaction has already been rejected');
                    if Rec."Rejection Reason" = '' then Error('Rejection reason must have a value');
                    Rec.Rejected := true;
                    Rec."Rejected By" := UserId;
                    Rec.Modify;
                    //Send SMS;
                    AgentApplications.Get(Rec."Agent Code");
                    msg := 'Dear Agent your Utility to FOSA transfer of amount KES ' + Format(Rec.Amount) + ' has been rejected, Reason: ' + Rec."Rejection Reason";
                    MobileNo := AgentApplications."Mobile No";
                    //SkyAgencyBanking.SendSmsWithID(Source::Agency, MobileNo, msg, Format("Transaction ID"), '', true, 220, false, 'AGENT', "Session ID", 'AGENT');
                    Message('Rejected Successfully');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        RejectedEditable := true;
        if Rec.Posted then
            RejectedEditable := false;
    end;

    var
        SkyAgencyBanking: Codeunit "Sky Agency Banking";
        RejectedEditable: Boolean;
        Source: Option ,Agency;
        msg: Text;
        MobileNo: Text;
        AgentApplications: Record "Agent Applications";
}

