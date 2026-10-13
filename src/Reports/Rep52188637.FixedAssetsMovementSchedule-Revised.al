report 50495 "FA Movement Schedule - Revised"
{
    Caption = 'Fixed Assets Movement ScheduleStatement Of Equity';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/FixedAssetsMovementSchedule - Revised.rdlc';
    dataset
    {
        dataitem(FinanceReports; FinanceReports)
        {
            RequestFilterFields = Year;

            column(SelectPeriodYear2; SelectPeriodYear2)
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(SelectPeriodEndYear2; SelectPeriodEndYear2)
            {
            }
            column(SelectPeriod; SelectPeriod)
            {
            }
            column(SelectPeriodEnd; SelectPeriodEnd)
            {
            }

            column(TotalCostYear2; TotalCostYear2)
            {
            }
            column(TotalAdditionsYear2; TotalAdditionsYear2)
            {
            }
            column(TotalDisposalYear2; TotalDisposalYear2)
            {
            }
            column(TotalEndYear2; TotalEndYear2)
            {
            }
            column(TotalCostDepYear2; TotalCostDepYear2)
            {
            }
            column(TotalChargeDepYear2; TotalChargeDepYear2)
            {
            }
            column(TotalDepDisposalYear2; TotalDepDisposalYear2)
            {
            }
            column(TotalEndDepYear2; TotalEndDepYear2)
            {
            }
            column(TotalCostYear1; TotalCostYear1)
            {
            }
            column(TotalAdditionsYear1; TotalAdditionsYear1)
            {
            }
            column(TotalDisposalYear1; TotalDisposalYear1)
            {
            }
            column(TotalEndYear1; TotalEndYear1)
            {
            }
            column(TotalCostDepYear1; TotalCostDepYear1)
            {
            }
            column(TotalChargeDepYear1; TotalChargeDepYear1)
            {
            }
            column(TotalDepDisposalYear1; TotalDepDisposalYear1)
            {
            }
            column(TotalEndDepYear1; TotalEndDepYear1)
            {
            }
            //start fosa
            column(FOSAAdditionsYear1; FOSAAdditionsYear1)
            {
            }
            column(FOSAStartYear1; FOSAStartYear1)
            {
            }
            column(FOSAEndYear1; FOSAEndYear1)
            {
            }
            column(FOSADisposalYear1; LandDisposalYear1)
            {
            }
            column(FOSANetBookValueYear1; FOSANetBookValueYear1)
            {
            }
            column(FOSAChargeForThePeriodYear1; FOSAChargeForThePeriodYear1)
            {
            }
            column(FOSADepEndYear1; FOSADepEndYear1)
            {
            }
            column(FOSADepStartYear1; FOSADepStartYear1)
            {
            }
            column(FOSADepDisposalYear1; FOSADepDisposalYear1)
            {
            }
            column(FOSAAdditionsYear2; FOSAAdditionsYear2)
            {
            }
            column(FOSAStartYear2; FOSAStartYear2)
            {
            }
            column(FOSAEndYear2; FOSAEndYear2)
            {
            }
            column(FOSADisposalYear2; FOSADisposalYear2)
            {
            }
            column(FOSANetBookValueYear2; FOSANetBookValueYear2)
            {
            }
            column(FOSAChargeForThePeriodYear2; FOSAChargeForThePeriodYear2)
            {
            }
            column(FOSADepEndYear2; FOSADepEndYear2)
            {
            }
            column(FOSADepStartYear2; FOSADepStartYear2)
            {
            }
            column(FOSADepDisposalYear2; FOSADepDisposalYear2)
            {
            }
            //end fosa
            //start Machonaery
            column(MACAdditionsYear1; MACAdditionsYear1)
            {
            }
            column(MACStartYear1; MACStartYear1)
            {
            }
            column(MACEndYear1; MACEndYear1)
            {
            }
            column(MACDisposalYear1; LandDisposalYear1)
            {
            }
            column(MACNetBookValueYear1; MACNetBookValueYear1)
            {
            }
            column(MACChargeForThePeriodYear1; MACChargeForThePeriodYear1)
            {
            }
            column(MACDepEndYear1; MACDepEndYear1)
            {
            }
            column(MACDepStartYear1; MACDepStartYear1)
            {
            }
            column(MACDepDisposalYear1; MACDepDisposalYear1)
            {
            }
            column(MACAdditionsYear2; MACAdditionsYear2)
            {
            }
            column(MACStartYear2; MACStartYear2)
            {
            }
            column(MACEndYear2; MACEndYear2)
            {
            }
            column(MACDisposalYear2; MACDisposalYear2)
            {
            }
            column(MACNetBookValueYear2; MACNetBookValueYear2)
            {
            }
            column(MACChargeForThePeriodYear2; MACChargeForThePeriodYear2)
            {
            }
            column(MACDepEndYear2; MACDepEndYear2)
            {
            }
            column(MACDepStartYear2; MACDepStartYear2)
            {
            }
            column(MACDepDisposalYear2; MACDepDisposalYear2)
            {
            }
            //end machinary
            column(LandAdditionsYear1; LandAdditionsYear1)
            {
            }
            column(LandStartYear1; LandStartYear1)
            {
            }
            column(LandEndYear1; LandEndYear1)
            {
            }
            column(LandDisposalYear1; LandDisposalYear1)
            {
            }
            column(LandNetBookValueYear1; LandNetBookValueYear1)
            {
            }
            column(LandChargeForThePeriodYear1; LandChargeForThePeriodYear1)
            {
            }
            column(LandDepEndYear1; LandDepEndYear1)
            {
            }
            column(LandDepStartYear1; LandDepStartYear1)
            {
            }
            column(LandDepDisposalYear1; LandDepDisposalYear1)
            {
            }
            column(LandAdditionsYear2; LandAdditionsYear2)
            {
            }
            column(LandStartYear2; LandStartYear2)
            {
            }
            column(LandEndYear2; LandEndYear2)
            {
            }
            column(LandDisposalYear2; LandDisposalYear2)
            {
            }
            column(LandNetBookValueYear2; LandNetBookValueYear2)
            {
            }
            column(LandChargeForThePeriodYear2; LandChargeForThePeriodYear2)
            {
            }
            column(LandDepEndYear2; LandDepEndYear2)
            {
            }
            column(LandDepStartYear2; LandDepStartYear2)
            {
            }
            column(LandDepDisposalYear2; LandDepDisposalYear2)
            {
            }
            column(FurnitureAdditionsYear1; FurnitureAdditionsYear1)
            {
            }
            column(FurnitureStartYear1; FurnitureStartYear1)
            {
            }
            column(FurnitureEndYear1; FurnitureEndYear1)
            {
            }
            column(FurnitureDisposalYear1; FurnitureDisposalYear1)
            {
            }
            column(FurnitureNetBookValueYear1; FurnitureNetBookValueYear1)
            {
            }
            column(FurnitureChargeForThePeriodYear1; FurnitureChargeForThePeriodYear1)
            {
            }
            column(FurnitureDepEndYear1; FurnitureDepEndYear1)
            {
            }
            column(FurnitureDepStartYear1; FurnitureDepStartYear1)
            {
            }
            column(FurnitureDepDisposalYear1; FurnitureDepDisposalYear1)
            {
            }
            column(FurnitureAdditionsYear2; FurnitureAdditionsYear2)
            {
            }
            column(FurnitureStartYear2; FurnitureStartYear2)
            {
            }
            column(FurnitureEndYear2; FurnitureEndYear2)
            {
            }
            column(FurnitureDisposalYear2; FurnitureDisposalYear2)
            {
            }
            column(FurnitureNetBookValueYear2; FurnitureNetBookValueYear2)
            {
            }
            column(FurnitureChargeForThePeriodYear2; FurnitureChargeForThePeriodYear2)
            {
            }
            column(FurnitureDepEndYear2; FurnitureDepEndYear2)
            {
            }
            column(FurnitureDepStartYear2; FurnitureDepStartYear2)
            {
            }
            column(FurnitureDepDisposalYear2; FurnitureDepDisposalYear2)
            {
            }
            column(OfficeAdditionsYear1; OfficeAdditionsYear1)
            {
            }
            column(OfficeStartYear1; OfficeStartYear1)
            {
            }
            column(OfficeEndYear1; OfficeEndYear1)
            {
            }
            column(OfficeDisposalYear1; OfficeDisposalYear1)
            {
            }
            column(OfficeNetBookValueYear1; OfficeNetBookValueYear1)
            {
            }
            column(OfficeChargeForThePeriodYear1; OfficeChargeForThePeriodYear1)
            {
            }
            column(OfficeDepEndYear1; OfficeDepEndYear1)
            {
            }
            column(OfficeDepStartYear1; OfficeDepStartYear1)
            {
            }
            column(OfficeDepDisposalYear1; OfficeDepDisposalYear1)
            {
            }
            column(OfficeAdditionsYear2; OfficeAdditionsYear2)
            {
            }
            column(OfficeStartYear2; OfficeStartYear2)
            {
            }
            column(OfficeEndYear2; OfficeEndYear2)
            {
            }
            column(OfficeDisposalYear2; OfficeDisposalYear2)
            {
            }
            column(OfficeNetBookValueYear2; OfficeNetBookValueYear2)
            {
            }
            column(OfficeChargeForThePeriodYear2; OfficeChargeForThePeriodYear2)
            {
            }
            column(OfficeDepEndYear2; OfficeDepEndYear2)
            {
            }
            column(OfficeDepStartYear2; OfficeDepStartYear2)
            {
            }
            column(OfficeDepDisposalYear2; OfficeDepDisposalYear2)
            {
            }
            column(CompAdditionsYear1; CompAdditionsYear1)
            {
            }
            column(CompStartYear1; CompStartYear1)
            {
            }
            column(CompEndYear1; CompEndYear1)
            {
            }
            column(CompDisposalYear1; CompDisposalYear1)
            {
            }
            column(CompNetBookValueYear1; CompNetBookValueYear1)
            {
            }
            column(CompChargeForThePeriodYear1; CompChargeForThePeriodYear1)
            {
            }
            column(CompDepEndYear1; CompDepEndYear1)
            {
            }
            column(CompDepStartYear1; CompDepStartYear1)
            {
            }
            column(CompDepDisposalYear1; CompDepDisposalYear1)
            {
            }
            column(CompAdditionsYear2; CompAdditionsYear2)
            {
            }
            column(CompStartYear2; CompStartYear2)
            {
            }
            column(CompEndYear2; CompEndYear2)
            {
            }
            column(CompDisposalYear2; CompDisposalYear2)
            {
            }
            column(CompNetBookValueYear2; CompNetBookValueYear2)
            {
            }
            column(CompChargeForThePeriodYear2; CompChargeForThePeriodYear2)
            {
            }
            column(CompDepEndYear2; CompDepEndYear2)
            {
            }
            column(CompDepStartYear2; CompDepStartYear2)
            {
            }
            column(CompDepDisposalYear2; CompDepDisposalYear2)
            {
            }
            column(VehicleAdditionsYear1; VehicleAdditionsYear1)
            {
            }
            column(VehicleStartYear1; VehicleStartYear1)
            {
            }
            column(VehicleEndYear1; VehicleEndYear1)
            {
            }
            column(VehicleDisposalYear1; VehicleDisposalYear1)
            {
            }
            column(VehicleNetBookValueYear1; VehicleNetBookValueYear1)
            {
            }
            column(VehicleChargeForThePeriodYear1; VehicleChargeForThePeriodYear1)
            {
            }
            column(VehicleDepEndYear1; VehicleDepEndYear1)
            {
            }
            column(VehicleDepStartYear1; VehicleDepStartYear1)
            {
            }
            column(VehicleDepDisposalYear1; VehicleDepDisposalYear1)
            {
            }
            column(VehicleAdditionsYear2; VehicleAdditionsYear2)
            {
            }
            column(VehicleStartYear2; VehicleStartYear2)
            {
            }
            column(VehicleEndYear2; VehicleEndYear2)
            {
            }
            column(VehicleDisposalYear2; VehicleDisposalYear2)
            {
            }
            column(VehicleNetBookValueYear2; VehicleNetBookValueYear2)
            {
            }
            column(VehicleChargeForThePeriodYear2; VehicleChargeForThePeriodYear2)
            {
            }
            column(VehicleDepEndYear2; VehicleDepEndYear2)
            {
            }
            column(VehicleDepStartYear2; VehicleDepStartYear2)
            {
            }
            column(VehicleDepDisposalYear2; VehicleDepDisposalYear2)
            {
            }

            column(BuildingAdditionsYear1; BuildingAdditionsYear1)
            {
            }
            column(BuildingStartYear1; BuildingStartYear1)
            {
            }
            column(BuildingEndYear1; BuildingEndYear1)
            {
            }
            column(BuildingDisposalYear1; BuildingDisposalYear1)
            {
            }
            column(BuildingNetBookValueYear1; BuildingNetBookValueYear1)
            {
            }
            column(BuildingChargeForThePeriodYear1; BuildingChargeForThePeriodYear1)
            {
            }
            column(BuildingDepEndYear1; BuildingDepEndYear1)
            {
            }
            column(BuildingDepStartYear1; BuildingDepStartYear1)
            {
            }
            column(BuildingDepDisposalYear1; BuildingDepDisposalYear1)
            {
            }
            column(BuildingAdditionsYear2; BuildingAdditionsYear2)
            {
            }
            column(BuildingStartYear2; BuildingStartYear2)
            {
            }
            column(BuildingEndYear2; BuildingEndYear2)
            {
            }
            column(BuildingDisposalYear2; BuildingDisposalYear2)
            {
            }
            column(BuildingNetBookValueYear2; BuildingNetBookValueYear2)
            {
            }
            column(BuildingChargeForThePeriodYear2; BuildingChargeForThePeriodYear2)
            {
            }
            column(BuildingDepEndYear2; BuildingDepEndYear2)
            {
            }
            column(BuildingDepStartYear2; BuildingDepStartYear2)
            {
            }
            column(BuildingDepDisposalYear2; BuildingDepDisposalYear2)
            {
            }
            column(TotalNetBookYear1; TotalNetBookYear1)
            {
            }
            column(TotalNetBookYear2; TotalNetBookYear2)
            {
            }

            trigger OnPreDataItem()
            begin

                FinanceReportsList.RESET;
                FinanceReportsList.SETRANGE(Year, CalcDate('-CY', TODAY));
                if not FinanceReportsList.findfirst then begin
                    FinanceReportsList.INIT;
                    FinanceReportsList.Year := CalcDate('-CY', TODAY);
                    FinanceReportsList.Insert();
                end;

                FASetup.get;

                CompanyInformation.Get();
                CompanyInformation.CalcFields(CompanyInformation.Picture);
            end;

            trigger OnAfterGetRecord()

            begin
                SelectPeriodYear2 := FinanceReports.Year;
                SelectPeriod := CALCDATE('-1Y', FinanceReports.Year);

                if SelectPeriod = 0D then
                    Error('Select Period First');

                SelectPeriodEnd := CalcDate('CY', SelectPeriod);
                SelectPeriodEndYear2 := CalcDate('CY', SelectPeriodYear2);

                //Land YEAR 1 MAC_EQUIP	
                LandStartYear1 := GetFABalance('LAND', 0D, SelectPeriod - 1, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                LandAdditionsYear1 := GetFABalance('LAND', SelectPeriod, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                LandDisposalYear1 := GetFABalance('LAND', SelectPeriod, SelectPeriodEnd, FAPostingCategory::Disposal, FAPostingType::"Acquisition Cost");
                LandEndYear1 := GetFABalance('LAND', 0D, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                LandNetBookValueYear1 := GetFANetValue('LAND', 0D, SelectPeriodEnd);


                LandDepEndYear1 := GetFABalance('LAND', 0D, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                LandChargeForThePeriodYear1 := 0;//(LandStartYear1 + LandAdditionsYear1 - LandDisposalYear1) * 1;
                LandDepStartYear1 := GetFABalance('LAND', 0D, SelectPeriod - 1, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                LandDepDisposalYear1 := GetFABalance('LAND', SelectPeriod, SelectPeriodEnd, FAPostingCategory::Disposal, FAPostingType::Depreciation);


                //Land YEAR 2
                LandStartYear2 := GetFABalance('LAND', 0D, SelectPeriodYear2 - 1, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                LandAdditionsYear2 := GetFABalance('LAND', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                LandDisposalYear2 := GetFABalance('LAND', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::Disposal, FAPostingType::"Acquisition Cost") * -1;
                LandEndYear2 := GetFABalance('LAND', 0D, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                LandNetBookValueYear2 := GetFANetValue('LAND', 0D, SelectPeriodEndYear2);


                LandDepEndYear2 := GetFABalance('LAND', 0D, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                LandChargeForThePeriodYear2 := 0;//(LandStartYear2 + LandAdditionsYear2 - LandDisposalYear2) * 1;
                LandDepStartYear2 := GetFABalance('LAND', 0D, SelectPeriodEndYear2 - 1, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                LandDepDisposalYear2 := GetFABalance('LAND', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::Disposal, FAPostingType::Depreciation);

                //1 MAC_EQUIP	
                LandStartYear1 := GetFABalance('LAND', 0D, SelectPeriod - 1, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                LandAdditionsYear1 := GetFABalance('LAND', SelectPeriod, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                LandDisposalYear1 := GetFABalance('LAND', SelectPeriod, SelectPeriodEnd, FAPostingCategory::Disposal, FAPostingType::"Acquisition Cost");
                LandEndYear1 := GetFABalance('LAND', 0D, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                LandNetBookValueYear1 := GetFANetValue('LAND', 0D, SelectPeriodEnd);


                LandDepEndYear1 := GetFABalance('LAND', 0D, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                LandChargeForThePeriodYear1 := 0;//(LandStartYear1 + LandAdditionsYear1 - LandDisposalYear1) * 1;
                LandDepStartYear1 := GetFABalance('LAND', 0D, SelectPeriod - 1, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                LandDepDisposalYear1 := GetFABalance('LAND', SelectPeriod, SelectPeriodEnd, FAPostingCategory::Disposal, FAPostingType::Depreciation);


                //Land YEAR 2
                LandStartYear2 := GetFABalance('LAND', 0D, SelectPeriodYear2 - 1, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                LandAdditionsYear2 := GetFABalance('LAND', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                LandDisposalYear2 := GetFABalance('LAND', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::Disposal, FAPostingType::"Acquisition Cost") * -1;
                LandEndYear2 := GetFABalance('LAND', 0D, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                LandNetBookValueYear2 := GetFANetValue('LAND', 0D, SelectPeriodEndYear2);


                LandDepEndYear2 := GetFABalance('LAND', 0D, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                LandChargeForThePeriodYear2 := 0;//(LandStartYear2 + LandAdditionsYear2 - LandDisposalYear2) * 1;
                LandDepStartYear2 := GetFABalance('LAND', 0D, SelectPeriodEndYear2 - 1, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                LandDepDisposalYear2 := GetFABalance('LAND', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::Disposal, FAPostingType::Depreciation);

                //FOSA YEAR 1
                FOSAStartYear1 := GetFABalance('PARTITIONS', 0D, SelectPeriod - 1, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                FOSAAdditionsYear1 := GetFABalance('PARTITIONS', SelectPeriod, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                FOSADisposalYear1 := GetFABalance('PARTITIONS', SelectPeriod, SelectPeriodEnd, FAPostingCategory::Disposal, FAPostingType::"Acquisition Cost");
                FOSAEndYear1 := GetFABalance('PARTITIONS', 0D, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                FOSANetBookValueYear1 := GetFANetValue('PARTITIONS', 0D, SelectPeriodEnd);


                FOSADepEndYear1 := GetFABalance('PARTITIONS', 0D, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                FOSAChargeForThePeriodYear1 := 0;//(LandStartYear1 + LandAdditionsYear1 - LandDisposalYear1) * 1;
                FOSADepStartYear1 := GetFABalance('PARTITIONS', 0D, SelectPeriod - 1, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                FOSADepDisposalYear1 := GetFABalance('PARTITIONS', SelectPeriod, SelectPeriodEnd, FAPostingCategory::Disposal, FAPostingType::Depreciation);


                //FOSA YEAR 2
                FOSAStartYear2 := GetFABalance('PARTITIONS', 0D, SelectPeriodYear2 - 1, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                FOSAAdditionsYear2 := GetFABalance('PARTITIONS', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                FOSADisposalYear2 := GetFABalance('PARTITIONS', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::Disposal, FAPostingType::"Acquisition Cost") * -1;
                FOSAEndYear2 := GetFABalance('PARTITIONS', 0D, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                FOSANetBookValueYear2 := GetFANetValue('PARTITIONS', 0D, SelectPeriodEndYear2);


                FOSADepEndYear2 := GetFABalance('PARTITIONS', 0D, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                FOSAChargeForThePeriodYear2 := 0;//(LandStartYear2 + LandAdditionsYear2 - LandDisposalYear2) * 1;
                FOSADepStartYear2 := GetFABalance('PARTITIONS', 0D, SelectPeriodEndYear2 - 1, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                FOSADepDisposalYear2 := GetFABalance('PARTITIONS', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::Disposal, FAPostingType::Depreciation);

                //MAC YEAR 1
                MACStartYear1 := GetFABalance('MAC_EQUIP', 0D, SelectPeriod - 1, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                MACAdditionsYear1 := GetFABalance('MAC_EQUIP', SelectPeriod, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                MACDisposalYear1 := GetFABalance('MAC_EQUIP', SelectPeriod, SelectPeriodEnd, FAPostingCategory::Disposal, FAPostingType::"Acquisition Cost");
                MACEndYear1 := GetFABalance('MAC_EQUIP', 0D, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                MACNetBookValueYear1 := GetFANetValue('MAC_EQUIP', 0D, SelectPeriodEnd);


                MACDepEndYear1 := GetFABalance('MAC_EQUIP', 0D, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                MACChargeForThePeriodYear1 := 0;//(LandStartYear1 + LandAdditionsYear1 - LandDisposalYear1) * 1;
                MACDepStartYear1 := GetFABalance('MAC_EQUIP', 0D, SelectPeriod - 1, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                MACDepDisposalYear1 := GetFABalance('MAC_EQUIP', SelectPeriod, SelectPeriodEnd, FAPostingCategory::Disposal, FAPostingType::Depreciation);


                //MAC YEAR 2
                MACStartYear2 := GetFABalance('MAC_EQUIP', 0D, SelectPeriodYear2 - 1, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                MACAdditionsYear2 := GetFABalance('MAC_EQUIP', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                MACDisposalYear2 := GetFABalance('MAC_EQUIP', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::Disposal, FAPostingType::"Acquisition Cost") * -1;
                MACEndYear2 := GetFABalance('MAC_EQUIP', 0D, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                MACNetBookValueYear2 := GetFANetValue('MAC_EQUIP', 0D, SelectPeriodEndYear2);


                MACDepEndYear2 := GetFABalance('MAC_EQUIP', 0D, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                MACChargeForThePeriodYear2 := 0;//(LandStartYear2 + LandAdditionsYear2 - LandDisposalYear2) * 1;
                MACDepStartYear2 := GetFABalance('MAC_EQUIP', 0D, SelectPeriodEndYear2 - 1, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                MACDepDisposalYear2 := GetFABalance('MAC_EQUIP', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::Disposal, FAPostingType::Depreciation);



                //Office YEAR 1
                OfficeStartYear1 := GetFABalance('EQUIPMENT', 0D, SelectPeriod - 1, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                OfficeAdditionsYear1 := GetFABalance('EQUIPMENT', SelectPeriod, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                OfficeDisposalYear1 := GetFABalance('EQUIPMENT', SelectPeriod, SelectPeriodEnd, FAPostingCategory::Disposal, FAPostingType::"Acquisition Cost") * -1;
                OfficeEndYear1 := GetFABalance('EQUIPMENT', 0D, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                OfficeNetBookValueYear1 := GetFANetValue('EQUIPMENT', 0D, SelectPeriodEnd);


                OfficeDepEndYear1 := GetFABalance('EQUIPMENT', 0D, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                OfficeDepStartYear1 := GetFABalance('EQUIPMENT', 0D, SelectPeriod - 1, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                OfficeChargeForThePeriodYear1 := (OfficeStartYear1 + OfficeAdditionsYear1 - OfficeDisposalYear1 - OfficeDepStartYear1) * 12.5 / 100;
                OfficeChargeForThePeriodYear1 := GetFABalance('EQUIPMENT', SelectPeriod, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                OfficeDepDisposalYear1 := GetFABalance('EQUIPMENT', SelectPeriod, SelectPeriodEnd, FAPostingCategory::Disposal, FAPostingType::Depreciation);


                //Office YEAR 2
                OfficeStartYear2 := GetFABalance('EQUIPMENT', 0D, SelectPeriodYear2 - 1, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                OfficeAdditionsYear2 := GetFABalance('EQUIPMENT', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                OfficeDisposalYear2 := GetFABalance('EQUIPMENT', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::Disposal, FAPostingType::"Acquisition Cost") * -1;
                OfficeEndYear2 := GetFABalance('EQUIPMENT', 0D, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                OfficeNetBookValueYear2 := GetFANetValue('EQUIPMENT', 0D, SelectPeriodEndYear2);


                OfficeDepEndYear2 := GetFABalance('EQUIPMENT', 0D, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                OfficeDepStartYear2 := GetFABalance('EQUIPMENT', 0D, SelectPeriodEndYear2 - 1, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                OfficeChargeForThePeriodYear2 := (OfficeStartYear2 + OfficeAdditionsYear2 - OfficeDisposalYear2 - OfficeDepStartYear2) * 12.5 / 100;
                OfficeChargeForThePeriodYear2 := GetFABalance('EQUIPMENT', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                OfficeDepDisposalYear2 := GetFABalance('EQUIPMENT', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::Disposal, FAPostingType::Depreciation);


                //Furniture YEAR 1
                FurnitureStartYear1 := GetFABalance('FURN_FITGN', 0D, SelectPeriod - 1, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                FurnitureAdditionsYear1 := GetFABalance('FURN_FITGN', SelectPeriod, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                FurnitureDisposalYear1 := GetFABalance('FURN_FITGN', SelectPeriod, SelectPeriodEnd, FAPostingCategory::Disposal, FAPostingType::"Acquisition Cost") * -1;
                FurnitureEndYear1 := GetFABalance('FURN_FITGN', 0D, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                FurnitureNetBookValueYear1 := GetFANetValue('FURN_FITGN', 0D, SelectPeriodEnd);


                FurnitureDepEndYear1 := GetFABalance('FURN_FITGN', 0D, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                FurnitureDepStartYear1 := GetFABalance('FURN_FITGN', 0D, SelectPeriod - 1, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                FurnitureChargeForThePeriodYear1 := (FurnitureStartYear1 + FurnitureAdditionsYear1 - FurnitureDisposalYear1 - FurnitureDepStartYear1) * 12.5 / 100;
                FurnitureChargeForThePeriodYear1 := GetFABalance('FURN_FITGN', SelectPeriod, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                FurnitureDepDisposalYear1 := GetFABalance('FURN_FITGN', SelectPeriod, SelectPeriodEnd, FAPostingCategory::Disposal, FAPostingType::Depreciation);


                //Furniture YEAR 2
                FurnitureStartYear2 := GetFABalance('FURN_FITGN', 0D, SelectPeriodYear2 - 1, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                FurnitureAdditionsYear2 := GetFABalance('FURN_FITGN', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                FurnitureDisposalYear2 := GetFABalance('FURN_FITGN', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::Disposal, FAPostingType::"Acquisition Cost") * -1;
                FurnitureEndYear2 := GetFABalance('FURN_FITGN', 0D, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                FurnitureNetBookValueYear2 := GetFANetValue('FURN_FITGN', 0D, SelectPeriodEndYear2);


                FurnitureDepEndYear2 := GetFABalance('FURN_FITGN', 0D, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                FurnitureDepStartYear2 := GetFABalance('FURN_FITGN', 0D, SelectPeriodEndYear2 - 1, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                FurnitureChargeForThePeriodYear2 := (FurnitureStartYear2 + FurnitureAdditionsYear2 - FurnitureDisposalYear2 - FurnitureDepStartYear2) * 12.5 / 100;
                FurnitureChargeForThePeriodYear2 := GetFABalance('FURN_FITGN', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                FurnitureDepDisposalYear2 := GetFABalance('FURN_FITGN', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::Disposal, FAPostingType::Depreciation);

                //Comp YEAR 1
                CompStartYear1 := GetFABalance('COMPUTER', 0D, SelectPeriod - 1, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                CompAdditionsYear1 := GetFABalance('COMPUTER', SelectPeriod, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                CompDisposalYear1 := GetFABalance('COMPUTER', SelectPeriod, SelectPeriodEnd, FAPostingCategory::Disposal, FAPostingType::"Acquisition Cost") * -1;
                CompEndYear1 := GetFABalance('COMPUTER', 0D, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                CompNetBookValueYear1 := GetFANetValue('COMPUTER', 0D, SelectPeriodEnd);


                CompDepEndYear1 := GetFABalance('COMPUTER', 0D, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                CompDepStartYear1 := GetFABalance('COMPUTER', 0D, SelectPeriod - 1, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                CompChargeForThePeriodYear1 := (CompStartYear1 + CompAdditionsYear1 - CompDisposalYear1 - CompDepStartYear1) * 30 / 100;
                CompChargeForThePeriodYear1 := GetFABalance('COMPUTER', SelectPeriod, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                CompDepDisposalYear1 := GetFABalance('COMPUTER', SelectPeriod, SelectPeriodEnd, FAPostingCategory::Disposal, FAPostingType::Depreciation);


                //Comp YEAR 2
                CompStartYear2 := GetFABalance('COMPUTER', 0D, SelectPeriodYear2 - 1, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                CompAdditionsYear2 := GetFABalance('COMPUTER', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                CompDisposalYear2 := GetFABalance('COMPUTER', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::Disposal, FAPostingType::"Acquisition Cost") * -1;
                CompEndYear2 := GetFABalance('COMPUTER', 0D, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                CompNetBookValueYear2 := GetFANetValue('COMPUTER', 0D, SelectPeriodEndYear2);


                CompDepEndYear2 := GetFABalance('COMPUTER', 0D, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                CompDepStartYear2 := GetFABalance('COMPUTER', 0D, SelectPeriodEndYear2 - 1, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                CompChargeForThePeriodYear2 := (CompStartYear2 + CompAdditionsYear2 - CompDisposalYear2 - CompDepStartYear2) * 30 / 100;
                CompChargeForThePeriodYear2 := GetFABalance('COMPUTER', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                CompDepDisposalYear2 := GetFABalance('COMPUTER', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::Disposal, FAPostingType::Depreciation);

                //Vehicle YEAR 1
                VehicleStartYear1 := GetFABalance('M VEHICLE', 0D, SelectPeriod - 1, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                VehicleAdditionsYear1 := GetFABalance('M VEHICLE', SelectPeriod, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                VehicleDisposalYear1 := GetFABalance('M VEHICLE', SelectPeriod, SelectPeriodEnd, FAPostingCategory::Disposal, FAPostingType::"Acquisition Cost") * -1;
                VehicleEndYear1 := GetFABalance('M VEHICLE', 0D, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                VehicleNetBookValueYear1 := GetFANetValue('M VEHICLE', 0D, SelectPeriodEnd);


                VehicleDepEndYear1 := GetFABalance('M VEHICLE', 0D, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                VehicleDepStartYear1 := GetFABalance('M VEHICLE', 0D, SelectPeriod - 1, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                VehicleChargeForThePeriodYear1 := (VehicleStartYear1 + VehicleAdditionsYear1 - VehicleDisposalYear1 - VehicleDepStartYear1) * 25 / 100;
                VehicleChargeForThePeriodYear1 := GetFABalance('M VEHICLE', SelectPeriod, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                VehicleDepDisposalYear1 := GetFABalance('M VEHICLE', SelectPeriod, SelectPeriodEnd, FAPostingCategory::Disposal, FAPostingType::Depreciation);


                //Vehicle YEAR 2
                VehicleStartYear2 := GetFABalance('M VEHICLE', 0D, SelectPeriodYear2 - 1, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                VehicleAdditionsYear2 := GetFABalance('M VEHICLE', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                VehicleDisposalYear2 := GetFABalance('M VEHICLE', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::Disposal, FAPostingType::"Acquisition Cost") * -1;
                VehicleEndYear2 := GetFABalance('M VEHICLE', 0D, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                VehicleNetBookValueYear2 := GetFANetValue('M VEHICLE', 0D, SelectPeriodEndYear2);


                VehicleDepEndYear2 := GetFABalance('M VEHICLE', 0D, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                VehicleDepStartYear2 := GetFABalance('M VEHICLE', 0D, SelectPeriodEndYear2 - 1, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                VehicleChargeForThePeriodYear2 := (VehicleStartYear2 + VehicleAdditionsYear2 - VehicleDisposalYear2 - VehicleDepStartYear2) * 25 / 100;
                VehicleChargeForThePeriodYear2 := GetFABalance('M VEHICLE', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                VehicleDepDisposalYear2 := GetFABalance('M VEHICLE', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::Disposal, FAPostingType::Depreciation);


                //Building YEAR 1
                BuildingStartYear1 := GetFABalance('BUILDING', 0D, SelectPeriod - 1, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                BuildingAdditionsYear1 := GetFABalance('BUILDING', SelectPeriod, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                BuildingDisposalYear1 := GetFABalance('BUILDING', SelectPeriod, SelectPeriodEnd, FAPostingCategory::Disposal, FAPostingType::"Acquisition Cost") * -1;
                BuildingEndYear1 := GetFABalance('BUILDING', 0D, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                BuildingNetBookValueYear1 := GetFANetValue('BUILDING', 0D, SelectPeriodEnd);


                BuildingDepEndYear1 := GetFABalance('BUILDING', 0D, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                BuildingDepStartYear1 := GetFABalance('BUILDING', 0D, SelectPeriod - 1, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                BuildingChargeForThePeriodYear1 := (BuildingStartYear1 + BuildingAdditionsYear1 - BuildingDisposalYear1 - BuildingDepStartYear1) * 2.5 / 100;
                BuildingChargeForThePeriodYear1 := GetFABalance('BUILDING', SelectPeriod, SelectPeriodEnd, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                BuildingDepDisposalYear1 := GetFABalance('BUILDING', SelectPeriod, SelectPeriodEnd, FAPostingCategory::Disposal, FAPostingType::Depreciation);


                //Building YEAR 2
                BuildingStartYear2 := GetFABalance('BUILDING', 0D, SelectPeriodYear2 - 1, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                BuildingAdditionsYear2 := GetFABalance('BUILDING', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                BuildingDisposalYear2 := GetFABalance('BUILDING', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::Disposal, FAPostingType::"Acquisition Cost") * -1;
                BuildingEndYear2 := GetFABalance('BUILDING', 0D, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::"Acquisition Cost");
                BuildingNetBookValueYear2 := GetFANetValue('BUILDING', 0D, SelectPeriodEndYear2);


                BuildingDepEndYear2 := GetFABalance('BUILDING', 0D, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                BuildingDepStartYear2 := GetFABalance('BUILDING', 0D, SelectPeriodEndYear2 - 1, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                BuildingChargeForThePeriodYear2 := (BuildingStartYear2 + BuildingAdditionsYear2 - BuildingDisposalYear2 - BuildingDepStartYear2) * 2.5 / 100;
                BuildingChargeForThePeriodYear2 := GetFABalance('BUILDING', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::" ", FAPostingType::Depreciation) * -1;
                BuildingDepDisposalYear2 := GetFABalance('BUILDING', SelectPeriodYear2, SelectPeriodEndYear2, FAPostingCategory::Disposal, FAPostingType::Depreciation);

                TotalCostYear2 := LandStartYear2 + MACStartYear2 + FOSAStartYear2 + BuildingStartYear2 + VehicleStartYear2 + CompStartYear2 + OfficeStartYear2 + FurnitureStartYear2;
                TotalAdditionsYear2 := LandAdditionsYear2 + MACAdditionsYear2 + FOSAAdditionsYear2 + BuildingAdditionsYear2 + VehicleAdditionsYear2 + CompAdditionsYear2 + OfficeAdditionsYear2 + FurnitureAdditionsYear2;
                TotalDisposalYear2 := LandDisposalYear2 + MACDisposalYear2 + FOSADisposalYear2 + BuildingDisposalYear2 + VehicleDisposalYear2 + CompDisposalYear2 + OfficeDisposalYear2 + FurnitureDisposalYear2;
                TotalEndYear2 := LandEndYear2 + MACEndYear2 + FOSAEndYear2 + BuildingEndYear2 + VehicleEndYear2 + CompEndYear2 + OfficeEndYear2 + FurnitureEndYear2;
                TotalCostDepYear2 := LandDepStartYear2 + MACDepStartYear2 + FOSADepStartYear2 + BuildingStartYear2 + VehicleStartYear2 + CompStartYear2 + OfficeStartYear2 + FurnitureStartYear2;
                TotalChargeDepYear2 := LandChargeForThePeriodYear2 + MACChargeForThePeriodYear2 + FOSAChargeForThePeriodYear2 + BuildingChargeForThePeriodYear2 + VehicleChargeForThePeriodYear2 + CompChargeForThePeriodYear2 + OfficeChargeForThePeriodYear2 + FurnitureChargeForThePeriodYear2;
                TotalDepDisposalYear2 := LandDepDisposalYear2 + MACDepDisposalYear2 + FOSADepDisposalYear2 + BuildingDepDisposalYear2 + VehicleDepDisposalYear2 + CompDepDisposalYear2 + OfficeDepDisposalYear2 + FurnitureDepDisposalYear2;
                TotalEndDepYear2 := LandDepEndYear2 + MACDepEndYear2 + FOSADepEndYear2 + BuildingDepEndYear2 + VehicleDepEndYear2 + CompDepEndYear2 + OfficeDepEndYear2 + FurnitureDepEndYear2;
                TotalCostYear1 := LandStartYear1 + MACStartYear1 + FOSAStartYear1 + BuildingStartYear1 + VehicleStartYear1 + CompStartYear1 + OfficeStartYear1 + FurnitureStartYear1;
                TotalAdditionsYear1 := LandAdditionsYear1 + MACAdditionsYear1 + FOSAAdditionsYear1 + BuildingAdditionsYear1 + VehicleAdditionsYear1 + CompAdditionsYear1 + OfficeAdditionsYear1 + FurnitureAdditionsYear1;
                TotalDisposalYear1 := LandDisposalYear1 + MACDisposalYear1 + FOSADisposalYear1 + BuildingDisposalYear1 + VehicleDisposalYear1 + CompDisposalYear1 + OfficeDisposalYear1 + FurnitureDisposalYear1;
                TotalEndYear1 := LandEndYear1 + MACEndYear1 + FOSAEndYear1 + BuildingEndYear1 + VehicleEndYear1 + CompEndYear1 + OfficeEndYear1 + FurnitureEndYear1;
                TotalCostDepYear1 := LandDepStartYear1 + MACDepStartYear1 + FOSADepStartYear1 + BuildingStartYear1 + VehicleStartYear1 + CompStartYear1 + OfficeStartYear1 + FurnitureStartYear1;
                TotalChargeDepYear1 := LandChargeForThePeriodYear1 + MACChargeForThePeriodYear1 + FOSAChargeForThePeriodYear1 + BuildingChargeForThePeriodYear1 + VehicleChargeForThePeriodYear1 + CompChargeForThePeriodYear1 + OfficeChargeForThePeriodYear1 + FurnitureChargeForThePeriodYear1;
                TotalDepDisposalYear1 := LandDepDisposalYear1 + MACDepDisposalYear1 + FOSADepDisposalYear1 + BuildingDepDisposalYear1 + VehicleDepDisposalYear1 + CompDepDisposalYear1 + OfficeDepDisposalYear1 + FurnitureDepDisposalYear1;
                TotalEndDepYear1 := LandDepEndYear1 + MACDepEndYear1 + FOSADepEndYear1 + BuildingDepEndYear1 + VehicleDepEndYear1 + CompDepEndYear1 + OfficeDepEndYear1 + FurnitureDepEndYear1;
                TotalNetBookYear1 := LandNetBookValueYear1 + MACNetBookValueYear1 + FOSANetBookValueYear1 + BuildingNetBookValueYear1 + VehicleNetBookValueYear1 + CompNetBookValueYear1 + OfficeNetBookValueYear1 + FurnitureNetBookValueYear1;
                TotalNetBookYear2 := LandNetBookValueYear2 + MACNetBookValueYear2 + FOSANetBookValueYear2 + BuildingNetBookValueYear2 + VehicleNetBookValueYear2 + CompNetBookValueYear2 + OfficeNetBookValueYear2 + FurnitureNetBookValueYear2;

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    var
        Number: Decimal;
        FinanceReportsList: Record FinanceReports;
        SelectPeriodYear2: Date;
        SelectPeriodEndYear2: Date;
        SelectPeriod: Date;
        SelectPeriodEnd: Date;
        FALedger: Record "FA Ledger Entry";
        VehiclesStartYear1: Decimal;
        VehiclesStartYear2: Decimal;
        CompsStartYear1: Decimal;
        CompsStartYear2: Decimal;

        //BUILDING
        BuildingStartYear1: Decimal;
        BuildingStartYear2: Decimal;
        BuildingEndYear1: Decimal;
        BuildingEndYear2: Decimal;
        BuildingDisposalYear1: Decimal;
        BuildingDisposalYear2: Decimal;
        BuildingAdditionsYear1: Decimal;
        BuildingAdditionsYear2: Decimal;
        BuildingChargeForThePeriodYear1: Decimal;
        BuildingChargeForThePeriodYear2: Decimal;
        BuildingNetBookValueYear1: Decimal;
        BuildingNetBookValueYear2: Decimal;
        BuildingDepEndYear1: Decimal;
        BuildingDepEndYear2: Decimal;
        BuildingDepStartYear1: Decimal;
        BuildingDepStartYear2: Decimal;
        BuildingDepDisposalYear1: Decimal;
        BuildingDepDisposalYear2: Decimal;
        //Office
        OfficeStartYear1: Decimal;
        OfficeStartYear2: Decimal;
        OfficeEndYear1: Decimal;
        OfficeEndYear2: Decimal;
        OfficeDisposalYear1: Decimal;
        OfficeDisposalYear2: Decimal;
        OfficeAdditionsYear1: Decimal;
        OfficeAdditionsYear2: Decimal;
        OfficeChargeForThePeriodYear1: Decimal;
        OfficeChargeForThePeriodYear2: Decimal;
        OfficeNetBookValueYear1: Decimal;
        OfficeNetBookValueYear2: Decimal;
        OfficeDepEndYear1: Decimal;
        OfficeDepEndYear2: Decimal;
        OfficeDepStartYear1: Decimal;
        OfficeDepStartYear2: Decimal;
        OfficeDepDisposalYear1: Decimal;
        OfficeDepDisposalYear2: Decimal;
        //VEHICLES
        VehicleStartYear1: Decimal;
        VehicleStartYear2: Decimal;
        VehicleEndYear1: Decimal;
        VehicleEndYear2: Decimal;
        VehicleDisposalYear1: Decimal;
        VehicleDisposalYear2: Decimal;
        VehicleAdditionsYear1: Decimal;
        VehicleAdditionsYear2: Decimal;
        VehicleChargeForThePeriodYear1: Decimal;
        VehicleChargeForThePeriodYear2: Decimal;
        VehicleNetBookValueYear1: Decimal;
        VehicleNetBookValueYear2: Decimal;
        VehicleDepEndYear1: Decimal;
        VehicleDepEndYear2: Decimal;
        VehicleDepStartYear1: Decimal;
        VehicleDepStartYear2: Decimal;
        VehicleDepDisposalYear1: Decimal;
        VehicleDepDisposalYear2: Decimal;
        //Computer
        CompStartYear1: Decimal;
        CompStartYear2: Decimal;
        CompEndYear1: Decimal;
        CompEndYear2: Decimal;
        CompDisposalYear1: Decimal;
        CompDisposalYear2: Decimal;
        CompAdditionsYear1: Decimal;
        CompAdditionsYear2: Decimal;
        CompChargeForThePeriodYear1: Decimal;
        CompChargeForThePeriodYear2: Decimal;
        CompNetBookValueYear1: Decimal;
        CompNetBookValueYear2: Decimal;
        CompDepEndYear1: Decimal;
        CompDepEndYear2: Decimal;
        CompDepStartYear1: Decimal;
        CompDepStartYear2: Decimal;
        CompDepDisposalYear1: Decimal;
        CompDepDisposalYear2: Decimal;
        LandAddYear1: Decimal;
        LandAddYear2: Decimal;
        BuildingAddYear1: Decimal;
        BuildingAddYear2: Decimal;
        VehiclesAddYear1: Decimal;
        VehiclesAddYear2: Decimal;
        CompsAddYear1: Decimal;
        CompsAddYear2: Decimal;
        OfficeAddYear1: Decimal;
        OfficeAddYear2: Decimal;
        //Furniture
        FurnitureStartYear1: Decimal;
        FurnitureStartYear2: Decimal;
        FurnitureEndYear1: Decimal;
        FurnitureEndYear2: Decimal;
        FurnitureDisposalYear1: Decimal;
        FurnitureDisposalYear2: Decimal;
        FurnitureAdditionsYear1: Decimal;
        FurnitureAdditionsYear2: Decimal;
        FurnitureChargeForThePeriodYear1: Decimal;
        FurnitureChargeForThePeriodYear2: Decimal;
        FurnitureNetBookValueYear1: Decimal;
        FurnitureNetBookValueYear2: Decimal;
        FurnitureDepEndYear1: Decimal;
        FurnitureDepEndYear2: Decimal;
        FurnitureDepStartYear1: Decimal;
        FurnitureDepStartYear2: Decimal;
        FurnitureDepDisposalYear1: Decimal;
        FurnitureDepDisposalYear2: Decimal;
        //Land
        LandStartYear1: Decimal;
        LandStartYear2: Decimal;
        LandEndYear1: Decimal;
        LandEndYear2: Decimal;
        LandDisposalYear1: Decimal;
        LandDisposalYear2: Decimal;
        LandAdditionsYear1: Decimal;
        LandAdditionsYear2: Decimal;
        LandChargeForThePeriodYear1: Decimal;
        LandChargeForThePeriodYear2: Decimal;
        LandNetBookValueYear1: Decimal;
        LandNetBookValueYear2: Decimal;
        LandDepEndYear1: Decimal;
        LandDepEndYear2: Decimal;
        LandDepStartYear1: Decimal;
        LandDepStartYear2: Decimal;
        LandDepDisposalYear1: Decimal;
        LandDepDisposalYear2: Decimal;
        //FOSA
        FOSAStartYear1: Decimal;
        FOSAStartYear2: Decimal;
        FOSAEndYear1: Decimal;
        FOSAEndYear2: Decimal;
        FOSADisposalYear1: Decimal;
        FOSADisposalYear2: Decimal;
        FOSAAdditionsYear1: Decimal;
        FOSAAdditionsYear2: Decimal;
        FOSAChargeForThePeriodYear1: Decimal;
        FOSAChargeForThePeriodYear2: Decimal;
        FOSANetBookValueYear1: Decimal;
        FOSANetBookValueYear2: Decimal;
        FOSADepEndYear1: Decimal;
        FOSADepEndYear2: Decimal;
        FOSADepStartYear1: Decimal;
        FOSADepStartYear2: Decimal;
        FOSADepDisposalYear1: Decimal;
        FOSADepDisposalYear2: Decimal;
        //MACH
        MACStartYear1: Decimal;
        MACStartYear2: Decimal;
        MACEndYear1: Decimal;
        MACEndYear2: Decimal;
        MACDisposalYear1: Decimal;
        MACDisposalYear2: Decimal;
        MACAdditionsYear1: Decimal;
        MACAdditionsYear2: Decimal;
        MACChargeForThePeriodYear1: Decimal;
        MACChargeForThePeriodYear2: Decimal;
        MACNetBookValueYear1: Decimal;
        MACNetBookValueYear2: Decimal;
        MACDepEndYear1: Decimal;
        MACDepEndYear2: Decimal;
        MACDepStartYear1: Decimal;
        MACDepStartYear2: Decimal;
        MACDepDisposalYear1: Decimal;
        MACDepDisposalYear2: Decimal;
        //TOTALS
        TotalCostYear2: Decimal;
        TotalAdditionsYear2: Decimal;
        TotalDisposalYear2: Decimal;
        TotalEndYear2: Decimal;
        TotalCostDepYear2: Decimal;
        TotalChargeDepYear2: Decimal;
        TotalDepDisposalYear2: Decimal;
        TotalEndDepYear2: Decimal;
        TotalCostYear1: Decimal;
        TotalAdditionsYear1: Decimal;
        TotalDisposalYear1: Decimal;
        TotalEndYear1: Decimal;
        TotalCostDepYear1: Decimal;
        TotalChargeDepYear1: Decimal;
        TotalDepDisposalYear1: Decimal;
        TotalEndDepYear1: Decimal;
        TotalNetBookYear1: Decimal;
        TotalNetBookYear2: Decimal;
        CompanyInformation: Record "Company Information";
        CompNetBookValueYear1Deductions1: Decimal;


        FAPostingCategory: Option " ",Disposal,"Bal. Disposal";

        FAPostingType: Enum "FA Ledger Entry FA Posting Type";

        FASetup: Record "FA Setup";





    procedure GetFABalance(SubClass: Code[20]; SDate: Date; EDate: Date; FAPostingCategory: Option " ",Disposal,"Bal. Disposal"; FAPostingType: Enum "FA Ledger Entry FA Posting Type") Bal: Decimal;
    var
        myInt: Integer;

    begin
        Bal := 0;

        //Land YEAR 1
        FALedger.RESET;
        FALedger.SetRange("FA Subclass Code", SubClass);
        FALedger.SetRange("Posting Date", SDate, EDate);
        if FAPostingCategory <> FAPostingCategory::" " then
            FALedger.SetRange("FA Posting Category", FAPostingCategory);
        FALedger.SetRange("FA Posting Type", FAPostingType);
        FALedger.Setrange("Depreciation Book Code", FASetup."Default Depr. Book");
        IF FALedger.FindFirst then begin
            FALedger.calcsums(Amount);
            Bal := FALedger.Amount;
        end;

    end;

    procedure GetFANetValue(SubClass: Code[20]; SDate: Date; EDate: Date) Bal: Decimal;
    var
        myInt: Integer;

    begin
        Bal := 0;

        //Land YEAR 1
        FALedger.RESET;
        FALedger.SetRange("FA Subclass Code", SubClass);
        FALedger.SetRange("Posting Date", SDate, EDate);
        FALedger.Setrange("Depreciation Book Code", FASetup."Default Depr. Book");
        FALedger.SetRange("Part of Book Value", true);
        IF FALedger.FindFirst then begin
            FALedger.calcsums(Amount);
            Bal := FALedger.Amount;
        end;

    end;
}
