Page 50955 "HR Transport Allocations List"
{
    ApplicationArea = All;
    CardPageID = "HR Transport Allocation";
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Transport Allocations Head";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field(TransportAllocationNo; Rec."Transport Allocation No")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(Destinations; Rec."Destination(s)")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(VehicleRegNumber; Rec."Vehicle Reg Number")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(DriverName; Rec."Driver Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field(DateofTrip; Rec."Date of Trip")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(TimeofTrip; Rec."Time of Trip")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755002; "HR Transport Alloc. Factbox")
            {
                Caption = 'HR Transport Allocations Factbox';
                SubPageLink = "Transport Allocation No" = field("Transport Allocation No");
            }
            systempart(Control1102755006; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action(Print)
                {
                    ApplicationArea = Basic;
                    Caption = '&Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;

                    /*trigger OnAction()
                    begin
                        HRTransportAllocationsH.Reset;
                        HRTransportAllocationsH.SetRange(HRTransportAllocationsH."Transport Allocation No","Transport Allocation No");
                        if HRTransportAllocationsH.Find('-') then
                        Report.Run(50999,true,true,HRTransportAllocationsH);
                    end;*/
                }
                action("<Action1102755035>p")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                        Message('Transport Allocation No :: :: has been Re-Opened', Rec."Transport Allocation No");
                    end;
                }
                action(Release)
                {
                    ApplicationArea = Basic;
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Question := Text001;
                        if Confirm(Question) then begin
                            Rec.Status := Rec.Status::Released;
                            Rec.Modify;
                            Message('Transport Allocation No :: :: has been released', Rec."Transport Allocation No");
                        end else begin
                            Message('You selected :: NO :: Release Cancelled');
                        end;
                    end;
                }
            }
        }
        area(reporting)
        {
        }
    }

    var
        //HRTransportAllocationsH: Record UnknownRecord39003963;
        Text19021002: label 'Passenger List';
        Text001: label 'Are you sure you want to Release this Document?';
        Question: Text;
}

