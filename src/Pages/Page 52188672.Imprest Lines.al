
Page 50335 "Imprest Lines"
{
    PageType = ListPart;
    SourceTable = "Imprest Lines";

    layout
    {
        area(content)
        {
            repeater(Control23)
            {
                field(AdvanceType; Rec."Advance Type")
                {
                    ApplicationArea = Basic;
                }
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(AccountNo; Rec."Account No:")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                /*
                field(DestinationCode;"Destination Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Destination Code';
                }
                field(NoofDays;"No of Days")
                {
                    ApplicationArea = Basic;
                }
                field(DailyRateAmount;"Daily Rate(Amount)")
                {
                    ApplicationArea = Basic;
                }
                */
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        /*{Get the total amount paid}
                        Bal:=0;
                        
                        PayHeader.RESET;
                        PayHeader.SETRANGE(PayHeader."Line No.",No);
                        IF PayHeader.FINDFIRST THEN
                          BEGIN
                            PayLine.RESET;
                            PayLine.SETRANGE(PayLine.No,PayHeader."Line No.");
                            IF PayLine.FIND('-') THEN
                              BEGIN
                                REPEAT
                                  Bal:=Bal + PayLine."Pay Mode";
                                UNTIL PayLine.NEXT=0;
                              END;
                          END;
                        //Bal:=Bal + Amount;
                        
                        IF Bal > PayHeader.Amount THEN
                          BEGIN
                            ERROR('Please ensure that the amount inserted does not exceed the amount in the header');
                          END;
                          */

                    end;
                }
                /*
                field(AmountLCY;"Amount LCY")
                {
                    ApplicationArea = Basic;
                }
                */
                field(ImprestHolder; Rec."Imprest Holder")
                {
                    ApplicationArea = Basic;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = Basic;
                }
                /*
                field(EndDate;Rec."Due Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'End Date';
                }
                
                field(BeginDate;Rec."Date Issued")
                {
                    ApplicationArea = Basic;
                    Caption = 'Begin Date';
                }
                */
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

