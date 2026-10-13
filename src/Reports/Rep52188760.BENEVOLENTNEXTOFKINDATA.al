report 50547 "BENEVOLENT/NEXT OF KIN DATA"
{
    ApplicationArea = All;
    Caption = 'Next of Kin/Nominee Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Benevolent Data.rdlc';

    dataset
    {
        dataitem(NextofKin; Integer)
        {
            DataItemTableView = sorting(Number);

            column(No; LineMemberNo)
            {
            }
            column(Name; LineName)
            {
            }
            column(IDNo; LineIDNo)
            {
            }
            column(DateofBirth; LineDateOfBirth)
            {
            }
            column(MobilePhoneNo; LineMobilePhoneNo)
            {
            }
            column(Relationship; LineRelationship)
            {
            }
            column(Email; LineEmail)
            {
            }
            column(Allocation; LineAllocation)
            {
            }
            column(Guardian_Details; LineGuardianDetails)
            {
            }
            column(SourceTable; LineSourceTable)
            {
            }
            column(CompanyName; Company.Name)
            {
            }
            column(CompanyPicture; Company.Picture)
            {
            }
            column(CompanyName_Members; MemberCompanyName)
            {
            }
            column(No_; MemberNo)
            {
            }
            column(Member_Name; MemberName)
            {
            }
            column(ID_No_; MemberIDNo)
            {
            }
            column(E_Mail; MemberEmail)
            {
            }
            column(Date_of_Birth; MemberDateOfBirth)
            {
            }
            column(Mobile_Phone_No_; MemberMobilePhoneNo)
            {
            }

            trigger OnPreDataItem()
            begin
                Company.Get();
                Company.CalcFields(Picture);

                BuildReportKeys();

                if ReportKeys.Count() = 0 then
                    CurrReport.Break();

                SetRange(Number, 1, ReportKeys.Count());
            end;

            trigger OnAfterGetRecord()
            begin
                ClearLineVariables();

                if not LoadCurrentLine(ReportKeys.Get(Number)) then
                    CurrReport.Skip();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(SourceFilter; SourceFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Source';
                        OptionCaption = 'All,Next of Kin,Nominee';
                    }
                    field(MemberNoFilter; MemberNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Member No. Filter';
                    }
                    field(NameFilter; NameFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Name Filter';
                    }
                    field(IDNoFilter; IDNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'ID No. Filter';
                    }
                    field(RelationshipFilter; RelationshipFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Relationship Filter';
                    }
                }
            }
        }
    }

    var
        Company: Record "Company Information";
        Members: Record Members;
        ReportKeys: List of [Text];
        SourceFilter: Option All,"Next of Kin",Nominee;
        MemberNoFilter: Text[250];
        NameFilter: Text[250];
        IDNoFilter: Text[250];
        RelationshipFilter: Text[250];
        LineMemberNo: Code[20];
        LineName: Text[50];
        LineIDNo: Code[20];
        LineDateOfBirth: Date;
        LineMobilePhoneNo: Text[30];
        LineRelationship: Text[30];
        LineEmail: Text[80];
        LineAllocation: Decimal;
        LineGuardianDetails: Text[150];
        LineSourceTable: Text[30];
        MemberNo: Code[20];
        MemberName: Text[100];
        MemberIDNo: Code[20];
        MemberEmail: Text[80];
        MemberDateOfBirth: Date;
        MemberMobilePhoneNo: Text[30];
        MemberCompanyName: Text[100];

    local procedure BuildReportKeys()
    begin
        Clear(ReportKeys);

        if SourceFilter in [SourceFilter::All, SourceFilter::"Next of Kin"] then
            AddNextOfKinKeys();

        if SourceFilter in [SourceFilter::All, SourceFilter::Nominee] then
            AddNomineeKeys();
    end;

    local procedure AddNextOfKinKeys()
    var
        NextOfKinRec: Record "Next of Kin.";
    begin
        ApplyNextOfKinFilters(NextOfKinRec);

        if NextOfKinRec.FindSet() then
            repeat
                ReportKeys.Add(
                    StrSubstNo(
                        'NOK|%1|%2|%3|%4|%5',
                        NextOfKinRec."No.",
                        NextOfKinRec."ID No.",
                        NextOfKinRec.Name,
                        NextOfKinRec."Principal ID No.",
                        NextOfKinRec."Line No."));
            until NextOfKinRec.Next() = 0;
    end;

    local procedure AddNomineeKeys()
    var
        NomineeRec: Record Nominee;
    begin
        ApplyNomineeFilters(NomineeRec);

        if NomineeRec.FindSet() then
            repeat
                ReportKeys.Add(StrSubstNo('NOM|%1|%2', NomineeRec."No.", NomineeRec."Line No."));
            until NomineeRec.Next() = 0;
    end;

    local procedure ApplyNextOfKinFilters(var NextOfKinRec: Record "Next of Kin.")
    begin
        NextOfKinRec.Reset();

        if MemberNoFilter <> '' then
            NextOfKinRec.SetFilter("No.", MemberNoFilter);

        if NameFilter <> '' then
            NextOfKinRec.SetFilter(Name, NameFilter);

        if IDNoFilter <> '' then
            NextOfKinRec.SetFilter("ID No.", IDNoFilter);

        if RelationshipFilter <> '' then
            NextOfKinRec.SetFilter(Relationship, RelationshipFilter);
    end;

    local procedure ApplyNomineeFilters(var NomineeRec: Record Nominee)
    begin
        NomineeRec.Reset();

        if MemberNoFilter <> '' then
            NomineeRec.SetFilter("No.", MemberNoFilter);

        if NameFilter <> '' then
            NomineeRec.SetFilter(Name, NameFilter);

        if IDNoFilter <> '' then
            NomineeRec.SetFilter("ID No.", IDNoFilter);

        if RelationshipFilter <> '' then
            NomineeRec.SetFilter(Relationship, RelationshipFilter);
    end;

    local procedure LoadCurrentLine(ReportKey: Text): Boolean
    var
        NextOfKinRec: Record "Next of Kin.";
        NomineeRec: Record Nominee;
        SourceCode: Text;
        KeyParts: List of [Text];
    begin
        KeyParts := ReportKey.Split('|');

        if KeyParts.Count() = 0 then
            exit(false);

        SourceCode := KeyParts.Get(1);

        case SourceCode of
            'NOK':
                begin
                    if KeyParts.Count() < 6 then
                        exit(false);

                    if not NextOfKinRec.Get(
                        CopyStr(KeyParts.Get(2), 1, MaxStrLen(NextOfKinRec."No.")),
                        CopyStr(KeyParts.Get(3), 1, MaxStrLen(NextOfKinRec."ID No.")),
                        CopyStr(KeyParts.Get(4), 1, MaxStrLen(NextOfKinRec.Name)),
                        CopyStr(KeyParts.Get(5), 1, MaxStrLen(NextOfKinRec."Principal ID No.")),
                        EvaluateInteger(KeyParts.Get(6)))
                    then
                        exit(false);

                    LoadNextOfKinLine(NextOfKinRec);
                    exit(true);
                end;
            'NOM':
                begin
                    if KeyParts.Count() < 3 then
                        exit(false);

                    if not NomineeRec.Get(
                        CopyStr(KeyParts.Get(2), 1, MaxStrLen(NomineeRec."No.")),
                        EvaluateInteger(KeyParts.Get(3)))
                    then
                        exit(false);

                    LoadNomineeLine(NomineeRec);
                    exit(true);
                end;
        end;

        exit(false);
    end;

    local procedure LoadNextOfKinLine(NextOfKinRec: Record "Next of Kin.")
    begin
        LineMemberNo := NextOfKinRec."No.";
        LineName := NextOfKinRec.Name;
        LineIDNo := NextOfKinRec."ID No.";
        LineDateOfBirth := NextOfKinRec."Date of Birth";
        LineMobilePhoneNo := NextOfKinRec."Mobile Phone No.";
        LineRelationship := NextOfKinRec.Relationship;
        LineEmail := GetNextOfKinEmail(NextOfKinRec);
        LineAllocation := NextOfKinRec."%Allocation";
        LineGuardianDetails := NextOfKinRec.GuardianName;
        LineSourceTable := 'Next of Kin';

        LoadMemberDetails(LineMemberNo);
    end;

    local procedure LoadNomineeLine(NomineeRec: Record Nominee)
    begin
        LineMemberNo := NomineeRec."No.";
        LineName := NomineeRec.Name;
        LineIDNo := NomineeRec."ID No.";
        LineDateOfBirth := NomineeRec."Date of Birth";
        LineMobilePhoneNo := NomineeRec."Mobile Phone No.";
        LineRelationship := NomineeRec.Relationship;
        LineEmail := GetNomineeEmail(NomineeRec);
        LineAllocation := NomineeRec."%Allocation";
        LineGuardianDetails := StrSubstNo('%1-%2', NomineeRec."Guardian Name", NomineeRec."Guardian Phone No.");
        LineSourceTable := 'Nominee';

        LoadMemberDetails(LineMemberNo);
    end;

    local procedure LoadMemberDetails(MemberNoToFind: Code[20])
    begin
        Clear(MemberNo);
        Clear(MemberName);
        Clear(MemberIDNo);
        Clear(MemberEmail);
        Clear(MemberDateOfBirth);
        Clear(MemberMobilePhoneNo);
        Clear(MemberCompanyName);

        if MemberNoToFind = '' then
            exit;

        if not Members.Get(MemberNoToFind) then
            exit;

        MemberNo := Members."No.";
        MemberName := Members.Name;
        MemberIDNo := Members."ID No.";
        MemberEmail := Members."E-Mail";
        MemberDateOfBirth := Members."Date of Birth";
        MemberMobilePhoneNo := Members."Mobile Phone No.";
        MemberCompanyName := Members."Company Name";
    end;

    local procedure ClearLineVariables()
    begin
        Clear(LineMemberNo);
        Clear(LineName);
        Clear(LineIDNo);
        Clear(LineDateOfBirth);
        Clear(LineMobilePhoneNo);
        Clear(LineRelationship);
        Clear(LineEmail);
        Clear(LineAllocation);
        Clear(LineGuardianDetails);
        Clear(LineSourceTable);
        Clear(MemberNo);
        Clear(MemberName);
        Clear(MemberIDNo);
        Clear(MemberEmail);
        Clear(MemberDateOfBirth);
        Clear(MemberMobilePhoneNo);
        Clear(MemberCompanyName);
    end;

    local procedure GetNextOfKinEmail(NextOfKinRec: Record "Next of Kin."): Text[80]
    begin
        if NextOfKinRec."E-Mail" <> '' then
            exit(NextOfKinRec."E-Mail");

        exit(NextOfKinRec.Email);
    end;

    local procedure GetNomineeEmail(NomineeRec: Record Nominee): Text[80]
    begin
        if NomineeRec."E-Mail" <> '' then
            exit(NomineeRec."E-Mail");

        exit(NomineeRec.Email);
    end;

    local procedure EvaluateInteger(ValueText: Text): Integer
    var
        Result: Integer;
    begin
        Evaluate(Result, ValueText);
        exit(Result);
    end;
}