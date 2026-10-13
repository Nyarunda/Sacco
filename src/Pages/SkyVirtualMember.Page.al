Page 50534 "Sky Virtual Member"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Sky Virtual Member";
    //SourceTableView = where("Sent To Application" = const(No));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EntryNo; Rec."Entry No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(IDNumber; Rec."ID Number")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(NameonIPRS; Rec."Name on IPRS")
                {
                    ApplicationArea = Basic;
                }
                field(DateOfBirth; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic;
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ServiceNumber; Rec."Service Number")
                {
                    ApplicationArea = Basic;
                }
                field(Employer; Rec.Employer)
                {
                    ApplicationArea = Basic;
                }
                field(EntryDate; Rec."Entry Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(EntryTime; Rec."Entry Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RefferedBy; Rec."Reffered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RefererMemberNo; Rec."Referer Member No")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerCode; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerName; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(PayrollNumber; Rec."Payroll Number")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Validated; Rec.Validated)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SentToApplication; Rec."Sent To Application")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ActionedBy; Rec."Actioned By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Validate)
            {
                ApplicationArea = Basic;
                Image = ValidateEmailLoggingSetup;
                Promoted = true;
            }
            action("Send To Application")
            {
                ApplicationArea = Basic;
                Image = SendConfirmation;
                Promoted = true;

                trigger OnAction()
                var
                    FirstName: Text[50];
                    SecondName: Text[50];
                    LastName: Text[50];
                    FirstSTRPOS: Integer;
                    SeccondAndLastName: Text;
                    SecondSTRPOS: Integer;
                    msg: Text;
                    RecruiterFound: Boolean;
                    UserSetup: Record "User Setup";
                    ResponsibilityCenter: Code[50];
                    ActivityCode: Code[50];
                    BranchCode: Code[50];
                    FullName: Text;
                begin
                    MemberApplication.Reset;
                    MemberApplication.SetRange("ID No.", Rec."ID Number");
                    if MemberApplication.FindFirst then Error('Another record with this ID Number already exists in the system');

                    //TESTFIELD("Employer Code");
                    RecruiterFound := false;
                    SeriesSetup.Get;
                    SeriesSetup.TestField(SeriesSetup."Virtual Member App. No");
                    //NoSeries.InitSeries(SeriesSetup."Virtual Member App. No", MemberApplication."No. Series", 0D, MemberApplication."No.", MemberApplication."No. Series");
                    // First verify the series relationship

                    if MemberApplication."No." = '' then begin
                        // Get the next number
                        MemberApplication."No." := NoSeries.GetNextNo(SeriesSetup."Virtual Member App. No", WorkDate(), true);
                        MemberApplication."No. Series" := SeriesSetup."Virtual Member App. No";
                    end;


                    RecruiterFound := false;
                    Members.Reset;
                    Members.SetFilter("Mobile Phone No.", '=%1|=%2', '+' + Rec."Reffered By", Rec."Reffered By");
                    if Members.FindFirst then begin
                        RecruiterMemberNo := Members."No.";
                        RecruiterName := Members.Name;
                        RecruiterFound := true;
                    end else begin
                        Message('Recruiter Phone No %1 not found', Rec."Reffered By");
                        RecruiterFound := false;
                    end;

                    MemberAppNo := MemberApplication."No.";
                    FullName := Rec."Name on IPRS";
                    if FullName = '' then FullName := Rec.Names;
                    FirstName := CopyStr(FullName, 1, StrPos(FullName, ' ') - 1);
                    FirstSTRPOS := StrPos(FullName, ' ');
                    SeccondAndLastName := CopyStr(FullName, FirstSTRPOS + 1, 100);
                    SecondSTRPOS := StrPos(SeccondAndLastName, ' ');
                    if SecondSTRPOS = 0 then
                        LastName := CopyStr(SeccondAndLastName, 1, 100)
                    else
                        SecondName := CopyStr(SeccondAndLastName, 1, SecondSTRPOS - 1);

                    if SecondSTRPOS > 1 then
                        LastName := CopyStr(SeccondAndLastName, SecondSTRPOS + 1, 100);

                    UserSetup.Reset;
                    UserSetup.SetRange("User ID", UserId);

                    MemberApplication.Init;
                    MemberApplication."First Name" := FirstName;
                    MemberApplication."Middle Name" := SecondName;
                    MemberApplication.Surname := LastName;
                    MemberApplication."No." := MemberAppNo;
                    MemberApplication."Alternative Phone No." := '+' + Rec.Telephone;
                    MemberApplication."Mobile Phone No." := '+' + Rec.Telephone;
                    MemberApplication."ID No." := Rec."ID Number";
                    MemberApplication.Name := FullName;
                    MemberApplication."Date of Birth" := Rec."Date Of Birth";
                    MemberApplication.Gender := Rec.Gender;
                    if RecruiterFound then begin
                        MemberApplication."Recruited By" := RecruiterMemberNo;
                        MemberApplication."Recruited by Type" := MemberApplication."recruited by type"::Website;
                        MemberApplication."Recruited By Name" := RecruiterName;
                    end;
                    //MemberApplication."Employer Code" := "Employer Code";
                    MemberApplication."Employer Name" := Rec."Employer Name";
                    MemberApplication."Payroll/Staff No." := Rec."Payroll Number";
                    MemberApplication."Application Date" := Today;
                    MemberApplication."Captured By" := UserId;
                    //MemberApplication.Nationality := Citizenship;
                    MemberApplication."Virtual Member" := true;
                    //MemberApplication."Membership Option" := MemberApplication."membership option"::Member;
                    MemberApplication."Virtual Member" := true;
                    MemberApplication.Validate(MemberApplication."Date of Birth");
                    MemberApplication.Insert;

                    //Auto Accounts
                    ProductFactory.Reset();
                    ProductFactory.SetFilter(ProductFactory."Auto Open Member Account", '%1', true);
                    ProductFactory.SetFilter(ProductFactory."Product Category", '<>%1 & <>%2', ProductFactory."product category"::"Fixed Deposit",
                                             ProductFactory."product category"::"Junior Savings");
                    if ProductFactory.Find('-') then begin
                        repeat
                            AutoOpenSavingAccs.Init;
                            AutoOpenSavingAccs.Code := MemberAppNo;
                            AutoOpenSavingAccs.Validate(AutoOpenSavingAccs.Code, ProductFactory."Product ID");
                            AutoOpenSavingAccs."Monthly Contribution" := ProductFactory."Minimum Contribution";
                            AutoOpenSavingAccs.Insert;
                        until ProductFactory.Next = 0;
                    end;


                    Rec.Validated := true;
                    Rec."Sent To Application" := true;
                    Rec."Actioned By" := UserId;
                    Rec.Modify;



                    msg := 'Dear ' + Rec.Names + ', your application has been received under ref no: ' + MemberAppNo +
                    '. Please indicate this ref no. on the form and submit to the Sacco to allow for completion of the registration ' +
                    'process. For help 0709943000.';
                    SkyMbanking.SendSms(Source::MBANKING, Rec.Telephone, msg, MemberAppNo, '', true, 205, false);

                    if RecruiterFound then begin
                        msg := 'Dear Member, thank you for introducing ' + Rec.Names + ' to Harambee Sacco. Application is being processed under ref no: ' + MemberAppNo +
                        '. For help 0709943000.';
                        SkyMbanking.SendSms(Source::MBANKING, Rec."Reffered By", msg, MemberAppNo, '', true, 205, false);
                    end;

                    Message('Application sent succsessfully');
                end;
            }
        }
    }

    var
        MemberApplication: Record "Member Registration";
        SeriesSetup: Record "Sales & Receivables Setup";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeries: Codeunit "No. Series";
        NoSeriesLine: Record "No. Series Line";
        MemberAppNo: Code[50];
        Members: Record Members;
        RecruiterMemberNo: Code[30];
        RecruiterName: Text[50];
        Source: Enum "SMS Source Enum";
        SkyMbanking: Codeunit "Sky MBanking";
        ProductFactory: Record "Product Setup";
        AutoOpenSavingAccs: Record "Default Savings Products.";
}

