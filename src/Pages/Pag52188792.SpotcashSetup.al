page 50552 "Spotcash Setup"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "SpotCash Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(VendorCommissionAccount; Rec."Vendor Commission Account")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Vendor Lookup";
                }
                field(VendorCommission; Rec."Vendor Commission")
                {
                    ApplicationArea = Basic;
                }
                field(VendorStaggeredFee; Rec."Vendor Staggered Fee")
                {
                    ApplicationArea = Basic;
                }
                field(VendorStaggeredCharge; Rec."Vendor Staggered Charge")
                {
                    ApplicationArea = Basic;
                }
                field(SaccoFeeAccount; Rec."Sacco Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field(SaccoFee; Rec."Sacco Fee")
                {
                    ApplicationArea = Basic;
                }
                field(SaccoStaggeredFee; Rec."Sacco Staggered Fee")
                {
                    ApplicationArea = Basic;
                }
                field(SaccoStaggeredCharge; Rec."Sacco Staggered Charge")
                {
                    ApplicationArea = Basic;
                }
                field(SafaricomAccount; Rec."Safaricom Account")
                {
                    ApplicationArea = Basic;
                }
                field(SafaricomFee; Rec."Safaricom Fee")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(SafcomStaggeredFee; Rec."Safcom Staggered Fee")
                {
                    ApplicationArea = Basic;
                }
                field(SafcomStaggeredCharge; Rec."Safcom Staggered Charge")
                {
                    ApplicationArea = Basic;
                }
                field(BankAccount; Rec."Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field(SafaricomDepChargesGL; Rec."Safaricom Dep Charges GL")
                {
                    ApplicationArea = Basic;
                }
                field(PrePaymentAccount; Rec."Pre-Payment Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(SMSCharge; Rec."SMS Charge")
                {
                    ApplicationArea = Basic;
                }
                field(SMSAccount; Rec."SMS Account")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionLimit; Rec."Transaction Limit")
                {
                    ApplicationArea = Basic;
                }
                field(NonMemberDebitAccount; Rec."Non-Member Debit Account")
                {
                    ApplicationArea = Basic;
                }
                field(DailyLimit; Rec."Daily Limit")
                {
                    ApplicationArea = Basic;
                }
                field(WeeklyLimit; Rec."Weekly Limit")
                {
                    ApplicationArea = Basic;
                }
                field(MonthlyLimit; Rec."Monthly Limit")
                {
                    ApplicationArea = Basic;
                }
                field(RestricttoStaff; Rec."Restrict to Staff")
                {
                    ApplicationArea = Basic;
                }
                field(RestricttoEmployer; Rec."Restrict to Employer")
                {
                    ApplicationArea = Basic;
                }
                field(RestricttoBoard; Rec."Restrict to Board")
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
            action("Update MPESA")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    Acc: Code[20];
                    Phone: Code[20];
                begin

                    Acc := '5000017665000';
                    Phone := '+254722346758';

                    Savings.Get(Acc);
                    Savings."Transactional Mobile No" := Phone;
                    Savings.Status := Savings.Status::Active;
                    Savings.Blocked := Savings.Blocked::" ";
                    Savings.Modify;

                    if not Auth.Get(Phone) then begin
                        Auth.Init;
                        Auth."Mobile No." := Phone;
                        Auth."Account No." := Acc;
                        Auth.Insert;
                    end;

                    Auth.Reset;
                    Auth.SetRange("Account No.", Savings."No.");
                    if Auth.FindFirst then begin
                        //Auth."Mobile No." := Savings."Transactional Mobile No";
                        //Auth.MODIFY;
                        Auth.Rename(Savings."Transactional Mobile No");
                        SkyMbanking.GenerateNewPin(CopyStr(Savings."Transactional Mobile No", 2, 12));
                    end;
                    Message('Updated');
                end;
            }
            action("Reset Pin")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    Savings.Get('5000000127000');
                    Savings."Transactional Mobile No" := '+254706405989';
                    Savings.Status := Savings.Status::Active;
                    Savings.Blocked := Savings.Blocked::" ";
                    Savings.Modify;

                    Auth.Reset;
                    Auth.SetRange("Account No.", Savings."No.");
                    if Auth.FindFirst then begin
                        //Auth."Mobile No." := Savings."Transactional Mobile No";
                        //Auth.MODIFY;
                        Auth.Rename(Savings."Transactional Mobile No");
                        Auth."Reset PIN" := true;
                        Auth.Modify;

                        SkyMbanking.PinReset;
                    end;
                    Message('Updated');
                end;
            }
            action("Activate Bosa")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    /*
Cust.GET('0019558');
Cust.Status := Cust.Status::Active;
Cust.MODIFY;

Savings.GET('5000000127000');
Savings."Registration Date" := 20170101D;
Savings.MODIFY;

MESSAGE('Updated');
                     */

                end;
            }
            action("Staggered Charges")
            {
                ApplicationArea = Basic;
                RunObject = Page "Sky Staggered Charges";
                //RunPageLink = "No." = field(No);
            }
        }
    }

    trigger OnInit()
    begin
        Permission.Reset();
        if Permission.FindFirst() then begin

            Permission.Reset;
            Permission.SetRange("User ID", UserId);
            Permission.SetRange("Sky Mobile Setups", true);
            if not Permission.FindFirst then
                Error('You do not have the following permission: "Sky Mobile Setups"');

        end;
    end;

    var
        Savings: Record "Savings Accounts";
        Auth: Record "Sky USSD Auth";
        SkyMbanking: Codeunit "Sky MBanking";
        Cust: Record Members;
        Permission: Record "Sky Permissions";


    procedure SkyPermissions()
    var
        Permission: Record "Sky Permissions";
    begin
        Permission.Reset;
        Permission.SetRange("User ID", UserId);
        Permission.SetRange("Sky Mobile Setups", true);
        if not Permission.FindFirst then
            Error('You do not have the following permission: "Sky Mobile Setups"');
    end;
}

