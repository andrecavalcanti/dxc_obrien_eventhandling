codeunit 50003 "DXCEventHandling"
{
    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesInvHeaderInsert', '', false, false)]

    local procedure HandleBeforeSalesInvHeaderInsertOnSalesPost(var SalesInvHeader : Record "Sales Invoice Header"; SalesHeader : Record "Sales Header");
            
    begin

        SalesHeader.CALCFIELDS("DXC Weights and Dims");
        SalesInvHeader."DXC Weights and Dims" := SalesHeader."DXC Weights and Dims";         

    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesShptHeaderInsert', '', false, false)]

    local procedure HandleBeforeSalesShptHeaderInsertOnSalesPost(var SalesShptHeader : Record "Sales Shipment Header"; SalesHeader : Record "Sales Header");
            
    begin

        SalesHeader.CALCFIELDS("DXC Weights and Dims");
        SalesShptHeader."DXC Weights and Dims" := SalesHeader."DXC Weights and Dims";         

    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesCrMemoHeaderInsert', '', false, false)]

    local procedure HandleBeforeSalesCrMemoHeaderInsertOnSalesPost(var SalesCrMemoHeader : Record "Sales Cr.Memo Header"; SalesHeader : Record "Sales Header");
            
    begin

        SalesHeader.CALCFIELDS("DXC Weights and Dims");
        SalesCrMemoHeader."DXC Weights and Dims" := SalesHeader."DXC Weights and Dims";         

    end;
    
    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeReturnRcptHeaderInsert', '', false, false)]
    local procedure HandleBeforeReturnRcptHeaderInsertOnSalesPost(var ReturnRcptHeader : Record "Return Receipt Header"; SalesHeader : Record "Sales Header");
            
    begin

        SalesHeader.CALCFIELDS("DXC Weights and Dims");
        ReturnRcptHeader."DXC Weights and Dims" := SalesHeader."DXC Weights and Dims";         

    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeValidateEvent', 'Sell-to Customer No.', false, false)]
    local procedure HandleBeforeValidateSellToCustNoOnSalesHeader(var Rec : Record "Sales Header";var xRec : Record "Sales Header";CurrFieldNo : Integer);
    var
        Customer : Record Customer;
    begin

        Customer.GET(Rec."Sell-to Customer No.");
        Rec."DXC Address 3" := Customer."DXC Address 3";
    end;    

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Ship-to Code', false, false)]
    local procedure HandleAfterValidateShipToCodeOnSalesHeader(var Rec : Record "Sales Header";var xRec : Record "Sales Header";CurrFieldNo : Integer);
    var        
        ShipToAddress : Record "Ship-to Address";
    begin
        if (Rec."Sell-to Customer No." <> '') and (Rec."Ship-to Code" <> '') then begin
          ShipToAddress.GET(Rec."Sell-to Customer No.",Rec."Ship-to Code");
          Rec."DXC Ship-to Address 3" := ShipToAddress."DXC Address 3";
        end;
    end;    

    //---T37---
    // >> AOB-75
    [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure HandleAfterValidateOnNoOnSalesLine(var Rec : Record "Sales Line"; var xRec : Record "Sales Line";CurrFieldNo : Integer)
    var 
        TariffNumber : Record "Tariff Number";
    begin
        if TariffNumber.Get(Rec."No.") then
            Rec."DXC Tariff Description" := TariffNumber.Description;   
        
    end;
    // << AOB-75

    // >> AOB-19
    [EventSubscriber(ObjectType::Codeunit, 414, 'OnAfterReopenSalesDoc', '', false, false)]
    local procedure HandleAfterReopenSalesDocOnReleaseSalesDocument(var SalesHeader : Record "Sales Header");
    var
        ArchiveManagement : Codeunit ArchiveManagement;
    begin

        if (SalesHeader."Document Type" <> SalesHeader."Document Type"::Order) then
          exit;

        ArchiveManagement.AutoArchiveSalesDocument(SalesHeader);
    end;

    // << AOB-19
    // >> AOB-11
     [EventSubscriber(ObjectType::Codeunit, 365, 'DXCOnBeforeFormatAddress', '', false, false)]
    local procedure HandleDXCOnBeforeFormatAddress(var Sender : Codeunit "Format Address";RecVar : Variant);
    var
        DataTypeManagement : Codeunit "Data Type Management";
        RecRef : RecordRef;
        Cust : Record Customer;
        SalesHeader : Record "Sales Header";
        SalesInvHeader : Record "Sales Invoice Header";
        SalesShipHeader : Record "Sales Shipment Header";
        SalesCrMemoHeader : Record "Sales Cr.Memo Header";
    begin

        DataTypeManagement.GetRecordRef(RecVar,RecRef);

        case RecRef.NUMBER of
          DATABASE::Customer:
            begin
              RecRef.SETTABLE(Cust);
              Sender.SetAddr3(Cust."DXC Address 3");
            end;
          DATABASE::"Sales Header":
            begin
              RecRef.SETTABLE(SalesHeader);
              Sender.SetAddr3(SalesHeader."DXC Address 3");
            end;
          DATABASE::"Sales Shipment Header":
            begin
              RecRef.SETTABLE(SalesShipHeader);
              Sender.SetAddr3(SalesShipHeader."DXC Address 3");
            end;
          DATABASE::"Sales Invoice Header":
            begin
              RecRef.SETTABLE(SalesInvHeader);
              Sender.SetAddr3(SalesInvHeader."DXC Address 3");
            end;
          DATABASE::"Sales Cr.Memo Header":
            begin
              RecRef.SETTABLE(SalesCrMemoHeader);
              Sender.SetAddr3(SalesCrMemoHeader."DXC Address 3");
            end;
        end;
    end;
    // << AOB-11

    
}