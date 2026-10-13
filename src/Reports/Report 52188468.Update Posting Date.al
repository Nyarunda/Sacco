
Report 50131 "Update Posting Date"
{
    DefaultLayout = RDLC;
    ProcessingOnly = true;
    RDLCLayout = './src/Layouts/Update Posting Date.rdlc';

    dataset
    {
        dataitem("User Setup"; "User Setup")
        {
            DataItemTableView = where(MBanking = const(false));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                d: Integer;
                m: Integer;
                y: Integer;
            begin
                if "User Setup"."Approval Reset Time" <> 0T then begin

                    if Time >= "User Setup"."Approval Reset Time" then begin
                        "User Setup"."Allow Posting From" := Today;
                        "User Setup"."Approval Reset Time" := 0T;
                        "User Setup"."Allow Posting To" := Today;
                        "User Setup".Modify();
                    end;

                end else begin

                    "User Setup"."Allow Posting From" := Today;

                    "User Setup"."Allow Posting To" := Today;
                    "User Setup".Modify();

                    if not "User Setup"."Register Time" then
                        "User Setup"."Register Time" := true;

                    /*  User.Reset;
                     User.SetRange("User Name", "User Setup"."User ID");
                     User.SetRange(State, User.State::Enabled);
                     if User.FindFirst then begin
                         Leave.Reset;
                         Leave.SetRange("Applicant User ID", User."User Name");
                         Leave.SetFilter("End Date", '>=%1', Today);
                         Leave.SetFilter("Start Date", '<=%1', Today);
                         Leave.SetRange(Status, Leave.Status::Approved);
                         if Leave.FindFirst then begin
                             User.State := User.State::Disabled;
                             User.Modify;
                         end; */

                    /*
                    if User."Next Password Change Date" = 0D then begin
                        d := Random(28);
                        m := Date2dmy(Today,2);
                        y := Date2dmy(Today,3);
                        User."Next Password Change Date" := Dmy2date(d,m,y);
                        if User."Next Password Change Date" < Today then begin
                            User."Next Password Change Date" := CalcDate('1M',User."Next Password Change Date");
                            User.Modify;
                        end;
                    end;

                    if User."Next Password Change Date" = Today then begin
                        User."Next Password Change Date" := CalcDate('1M',User."Next Password Change Date");
                        User."Change Password" := true;
                        User.Modify;
                    end;
                    */
                end;


                Modify;
            end;


            //end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        User: Record User;
        Leave: Record "HR Leave Application.";
}

