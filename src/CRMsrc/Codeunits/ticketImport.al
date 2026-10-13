// Create this new Codeunit for handling the import logic
codeunit 50402 "Import Tickets"
{
    procedure ImportTicketsFromExcel()
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        TicketHeader: Record "Ticket Header";
        CRMCustomer: Record "CRM Customer";
        FileName: Text;
        SheetName: Text;
        InStream: InStream;
        OpenExcelFile: label 'Open Excel File';
        ExcelFileFilter: label 'Excel Files (*.xls*)|*.xls*|All Files (*.*)|*.*';
        ReadingFile: label 'Reading File';
        CurrentLine: label 'Current Line No.';
        NoOfLines: label 'No. of Lines';
        Window: Dialog;
        WindowLastUpdated: DateTime;
        Counter: Integer;
        Total: Integer;
        RowNo: Integer;
        ColNo: Integer;
        ImportedCount: Integer;
        ErrorCount: Integer;
        ErrorText: Text;
        TicketNo: Code[20];
        CustomerNo: Code[20];
        CustomerName: Text[100];
        Title: Text[100];
        Description: Text[2000];
        Priority: Text[30];
        Status: Text[30];
        TicketType: Text[30];
        TicketSource: Text[30];
        DueDateText: Text;
        DueDate: Date;
        AssignedTo: Code[50];
        DepartmentCode: Code[20];
    begin
        // Use UploadIntoStream for cloud compatibility
        if not UploadIntoStream(OpenExcelFile, '', ExcelFileFilter, FileName, InStream) then
            exit;

        // Import from stream instead of file path
        SheetName := TempExcelBuffer.SelectSheetsNameStream(InStream);
        TempExcelBuffer.OpenBookStream(InStream, SheetName);
        TempExcelBuffer.ReadSheet;
        TempExcelBuffer.SetFilter("Row No.", '>%1', 1); // Skip header row
        Total := TempExcelBuffer.Count;

        if Total = 0 then begin
            Error('No data found in the Excel file.');
            exit;
        end;
        Counter := 0;
        Window.Open(
          ReadingFile + ' @1@@@@@@@@@@@@@@@@@@@@@@@@\' +
          CurrentLine + ' #2#######\' +
          NoOfLines + '#3#######');
        Window.Update(3, Total);
        WindowLastUpdated := CurrentDateTime;

        if TempExcelBuffer.Find('-') then
            repeat
                Counter += 1;
                RowNo := TempExcelBuffer."Row No.";
                ColNo := TempExcelBuffer."Column No.";

                // Process columns for current row
                case ColNo of
                    1: // Ticket No. (optional)
                        begin
                            if TempExcelBuffer."Cell Value as Text" <> '' then
                                TicketNo := CopyStr(TempExcelBuffer."Cell Value as Text", 1, 20);
                        end;
                    2: // Customer No. (required)
                        begin
                            CustomerNo := CopyStr(TempExcelBuffer."Cell Value as Text", 1, 20);
                        end;
                    3: // Customer Name
                        begin
                            CustomerName := CopyStr(TempExcelBuffer."Cell Value as Text", 1, 100);
                        end;
                    4: // Title (required)
                        begin
                            Title := CopyStr(TempExcelBuffer."Cell Value as Text", 1, 100);
                        end;
                    5: // Description
                        begin
                            Description := CopyStr(TempExcelBuffer."Cell Value as Text", 1, 2000);
                        end;
                    6: // Priority
                        begin
                            Priority := CopyStr(TempExcelBuffer."Cell Value as Text", 1, 30);
                        end;
                    7: // Status
                        begin
                            Status := CopyStr(TempExcelBuffer."Cell Value as Text", 1, 30);
                        end;
                    8: // Ticket Type
                        begin
                            TicketType := CopyStr(TempExcelBuffer."Cell Value as Text", 1, 30);
                        end;
                    9: // Ticket Source
                        begin
                            TicketSource := CopyStr(TempExcelBuffer."Cell Value as Text", 1, 30);
                        end;
                    10: // Due Date
                        begin
                            DueDateText := TempExcelBuffer."Cell Value as Text";
                            if DueDateText <> '' then
                                if not Evaluate(DueDate, DueDateText) then
                                    ErrorText += 'Invalid Due Date; ';
                        end;
                    11: // Assigned To
                        begin
                            AssignedTo := CopyStr(TempExcelBuffer."Cell Value as Text", 1, 50);
                        end;
                    12: // Department Code - Process and create ticket
                        begin
                            DepartmentCode := CopyStr(TempExcelBuffer."Cell Value as Text", 1, 20);

                            // Now we have all data for this row, validate and create ticket
                            Clear(ErrorText);

                            // Validate required fields
                            if CustomerNo = '' then
                                ErrorText += 'Customer No. is required; ';

                            if Title = '' then
                                ErrorText += 'Title is required; ';

                            // Validate customer exists or create customer
                            if (CustomerNo <> '') and (ErrorText = '') then begin
                                if not CRMCustomer.Get(CustomerNo) then begin
                                    if CustomerName = '' then
                                        ErrorText += 'Customer does not exist and no customer name provided; '
                                    else begin
                                        // Create new customer if it doesn't exist
                                        CRMCustomer.Init();
                                        CRMCustomer."No." := CustomerNo;
                                        CRMCustomer.Name := CustomerName;
                                        CRMCustomer."Registration Date" := Today;
                                        CRMCustomer."Customer Status" := CRMCustomer."Customer Status"::Active;
                                        if CRMCustomer.Insert() then
                                            CustomerName := CRMCustomer.Name
                                        else
                                            ErrorText += 'Failed to create customer; ';
                                    end;
                                end else
                                    CustomerName := CRMCustomer.Name;
                            end;

                            // If no errors, create the ticket
                            if ErrorText = '' then begin
                                TicketHeader.Init();

                                // Set ticket number (use provided or generate new)
                                if TicketNo <> '' then begin
                                    if TicketHeader.Get(TicketNo) then
                                        ErrorText += 'Ticket No. already exists; '
                                    else
                                        TicketHeader."No." := TicketNo;
                                end;

                                if ErrorText = '' then begin
                                    TicketHeader."Customer No." := CustomerNo;
                                    TicketHeader."Customer Name" := CustomerName;
                                    TicketHeader.Title := Title;
                                    TicketHeader.Description := Description;
                                    TicketHeader."Created Date" := Today;
                                    TicketHeader."Created DateTime" := CurrentDateTime;
                                    TicketHeader."Created Time" := Time;

                                    // Set Due Date if provided
                                    if DueDate <> 0D then
                                        TicketHeader."Due Date" := DueDate;

                                    // Set Assigned To if provided
                                    if AssignedTo <> '' then
                                        TicketHeader."Assigned To" := AssignedTo;

                                    // Set Department if provided
                                    if DepartmentCode <> '' then
                                        TicketHeader."Department Code" := DepartmentCode;

                                    // Set enums based on text values
                                    SetTicketEnums(TicketHeader, Priority, Status, TicketType, TicketSource);

                                    if TicketHeader.Insert(true) then
                                        ImportedCount += 1
                                    else begin
                                        ErrorText += 'Failed to insert ticket; ';
                                        ErrorCount += 1;
                                    end;
                                end else
                                    ErrorCount += 1;
                            end else
                                ErrorCount += 1;

                            // Log errors if any
                            if ErrorText <> '' then
                                LogImportError(RowNo, ErrorText);

                            // Clear variables for next row
                            Clear(TicketNo);
                            Clear(CustomerNo);
                            Clear(CustomerName);
                            Clear(Title);
                            Clear(Description);
                            Clear(Priority);
                            Clear(Status);
                            Clear(TicketType);
                            Clear(TicketSource);
                            Clear(DueDate);
                            Clear(AssignedTo);
                            Clear(DepartmentCode);
                        end;
                end;

                if CurrentDateTime - WindowLastUpdated > 100 then begin
                    Window.Update(1, Round(Counter / Total * 10000, 1));
                    Window.Update(2, Counter);
                    WindowLastUpdated := CurrentDateTime;
                end;
            until TempExcelBuffer.Next = 0;
        Window.Close;

        // Show import results
        Message('Import completed.\Imported: %1 tickets\Errors: %2 tickets', ImportedCount, ErrorCount);
    end;



    local procedure SetTicketEnums(var TicketHeader: Record "Ticket Header"; Priority: Text; Status: Text; TicketType: Text; TicketSource: Text)
    begin
        // Set Priority (adjust based on your enum values)
        case UpperCase(Priority) of
            'LOW':
                TicketHeader.Priority := TicketHeader.Priority::Low;
            'MEDIUM', 'NORMAL':
                TicketHeader.Priority := TicketHeader.Priority::Medium;
            'HIGH':
                TicketHeader.Priority := TicketHeader.Priority::High;
            'URGENT', 'CRITICAL':
                TicketHeader.Priority := TicketHeader.Priority::Urgent;
            else
                TicketHeader.Priority := TicketHeader.Priority::Medium; // Default
        end;

        // Set Status (adjust based on your enum values)
        case UpperCase(Status) of
            'OPEN', 'NEW':
                TicketHeader.Status := TicketHeader.Status::Open;
            'IN PROGRESS', 'INPROGRESS', 'WORKING':
                TicketHeader.Status := TicketHeader.Status::InProgress;
            'RESOLVED':
                TicketHeader.Status := TicketHeader.Status::Resolved;
            'CLOSED':
                TicketHeader.Status := TicketHeader.Status::Closed;
            else
                TicketHeader.Status := TicketHeader.Status::Open; // Default
        end;

        // Set Ticket Type (adjust based on your enum values)
        case UpperCase(TicketType) of
            'TECHNICAL':
                TicketHeader."Ticket Type" := TicketHeader."Ticket Type"::Technical;
            'FUNCTIONAL':
                TicketHeader."Ticket Type" := TicketHeader."Ticket Type"::Functional;
            else
                TicketHeader."Ticket Type" := TicketHeader."Ticket Type"::General; // Default
        end;

        // Set Ticket Source (adjust based on your enum values)
        case UpperCase(TicketSource) of
            'EMAIL':
                TicketHeader."Ticket Source" := TicketHeader."Ticket Source"::Email;
            'PHONE':
                TicketHeader."Ticket Source" := TicketHeader."Ticket Source"::Phone;
            else
                TicketHeader."Ticket Source" := TicketHeader."Ticket Source"::Email; // Default
        end;
    end;

    local procedure LogImportError(RowNo: Integer; ErrorText: Text)
    begin
        // You can implement error logging here
        // For now, we'll just use a simple message for debugging
        // In production, you might want to create an "Import Error Log" table
        Message('Row %1: %2', RowNo, ErrorText);
    end;
}

// Template for Excel structure (inform users about required columns):
/*
Expected Excel Structure:
Column A: Ticket No. (optional - will be auto-generated if empty)
Column B: Customer No. (required)
Column C: Customer Name (required if customer doesn't exist)
Column D: Title (required)
Column E: Description
Column F: Priority (Low/Medium/High/Urgent)
Column G: Status (Open/In Progress/Resolved/Closed)
Column H: Ticket Type (Incident/Request/Problem/Change)
Column I: Ticket Source (Email/Phone/Web/Chat)
Column J: Due Date (Date format)
Column K: Assigned To
Column L: Department Code
*/
