codeunit 59999 "Loan Graduation Setup Mgt"
{
    procedure EnsureDefaultModel()
    var
        Model: Record "Loan Graduation Model";
        Product: Record "Loan Graduation Product";
        Band: Record "Loan Graduation Band";
        Weight: Record "Loan Graduation Score Weight";
    begin
        Model.Reset();
        if Model.FindFirst() then
            exit;

        Model.Init();
        Model."Code" := 'HELA-V1';
        Model.Description := 'Hela Chap Chap Mobile Loan Scoring';
        Model."Version No." := 'V1.0';
        Model.Active := true;
        Model."Evaluation Period Months" := 12;
        Model."Minimum Qualifying Score" := 50;
        Model."Grace Days Before Due" := 7;
        Model."Grace Days After Due" := 30;
        Model."On Time Grace Days" := 7;
        Model.Insert(true);

        Product.Init();
        Product."Model Code" := Model."Code";
        Product."Loan Product Type" := 'HELA';
        Product."Product Role" := Product."Product Role"::Scored;
        Product.Insert(true);

        Product.Init();
        Product."Model Code" := Model."Code";
        Product."Loan Product Type" := 'MOBILE LOAN';
        Product."Product Role" := Product."Product Role"::Scored;
        Product.Insert(true);

        Weight.Init();
        Weight."Model Code" := Model."Code";
        Weight."Score Area" := Weight."Score Area"::Repayment;
        Weight.Weight := 45;
        Weight."Maximum Raw Score" := 45;
        Weight.Insert(true);

        Weight.Init();
        Weight."Model Code" := Model."Code";
        Weight."Score Area" := Weight."Score Area"::Savings;
        Weight.Weight := 20;
        Weight."Maximum Raw Score" := 20;
        Weight.Insert(true);

        Weight.Init();
        Weight."Model Code" := Model."Code";
        Weight."Score Area" := Weight."Score Area"::CRB;
        Weight.Weight := 20;
        Weight."Maximum Raw Score" := 20;
        Weight.Insert(true);

        Weight.Init();
        Weight."Model Code" := Model."Code";
        Weight."Score Area" := Weight."Score Area"::Ratio;
        Weight.Weight := 10;
        Weight."Maximum Raw Score" := 10;
        Weight.Insert(true);

        Weight.Init();
        Weight."Model Code" := Model."Code";
        Weight."Score Area" := Weight."Score Area"::Membership;
        Weight.Weight := 5;
        Weight."Maximum Raw Score" := 5;
        Weight.Insert(true);

        Band.Init();
        Band."Model Code" := Model."Code";
        Band."Min Score" := 80;
        Band."Max Score" := 100;
        Band."Tier" := Band."Tier"::"Tier A";
        Band."Risk Category" := Band."Risk Category"::"Very Low Risk";
        Band."Eligible Amount" := 100000;
        Band.Qualified := true;
        Band.Insert(true);

        Band.Init();
        Band."Model Code" := Model."Code";
        Band."Min Score" := 65;
        Band."Max Score" := 79.99;
        Band."Tier" := Band."Tier"::"Tier B";
        Band."Risk Category" := Band."Risk Category"::"Low Risk";
        Band."Eligible Amount" := 50000;
        Band.Qualified := true;
        Band.Insert(true);

        Band.Init();
        Band."Model Code" := Model."Code";
        Band."Min Score" := 50;
        Band."Max Score" := 64.99;
        Band."Tier" := Band."Tier"::"Tier C";
        Band."Risk Category" := Band."Risk Category"::"Moderate Risk";
        Band."Eligible Amount" := 20000;
        Band.Qualified := true;
        Band.Insert(true);

        Band.Init();
        Band."Model Code" := Model."Code";
        Band."Min Score" := 40;
        Band."Max Score" := 49.99;
        Band."Tier" := Band."Tier"::"Tier D";
        Band."Risk Category" := Band."Risk Category"::"High Risk";
        Band."Eligible Amount" := 5000;
        Band.Qualified := false;
        Band.Insert(true);

        Band.Init();
        Band."Model Code" := Model."Code";
        Band."Min Score" := 0;
        Band."Max Score" := 39.99;
        Band."Tier" := Band."Tier"::"Tier D";
        Band."Risk Category" := Band."Risk Category"::"Very High Risk";
        Band."Eligible Amount" := 0;
        Band.Qualified := false;
        Band.Insert(true);
    end;
}
