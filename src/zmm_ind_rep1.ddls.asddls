@AbapCatalog.sqlViewName: 'ZMM_IND1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'indent register'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view ZMM_IND_REP1

 as select from I_PurchaseRequisitionAPI01 as e

    left outer join I_PurchaseRequisitionItemAPI01 as d
      on d.PurchaseRequisition = e.PurchaseRequisition
      
      
      left outer join I_PurchaseOrderItemAPI01 as a
      on a.PurchaseRequisition     = d.PurchaseRequisition
     and a.PurchaseRequisitionItem = d.PurchaseRequisitionItem 
   
     

    left outer join I_PurchaseOrderHistoryAPI01    as b

    //    on  b.PurchasingHistoryDocument  = a.PurchaseOrder
    
                                                        on  b.PurchaseOrder     = a.PurchaseOrder
                                                        and b.PurchaseOrderItem = a.PurchaseOrderItem
                                                        
                                                     
                                                        
                                                        
                                                       // and a.PurchaseRequisition is not initial
                                                        
                                                        and b.PurchasingHistoryCategory = 'E'      
                                                             

    left outer join ZMM_INDGRN_REPORT1             as c on 
    c.PurchaseOrder     = a.PurchaseOrder
                                                       and c.PurchaseOrderItem = a.PurchaseOrderItem
//                                                         c.PurchaseOrder = a.PurchaseOrder
       //                                                 and c.PurchaseOrderItem = b.PurchaseOrderItem
                                                         and c.MaterialDocument =b.PurchasingHistoryDocument
                                                         and c.MaterialDocumentItem = b.PurchasingHistoryDocumentItem
                                                         and c.MaterialDocumentYear = b.PurchasingHistoryDocumentYear


   // left outer join I_PurchaseRequisitionAPI01     as e on e.PurchaseRequisition = a.PurchaseRequisition

  

{
//
  key coalesce( a.PurchaseOrder, 'NA' )       as PurchaseOrder,
  key coalesce( a.PurchaseOrderItem, '0000' ) as PurchaseOrderItem,
/* PR Keys */
  key d.PurchaseRequisition,
  key d.PurchaseRequisitionItem,
//
//  key a.PurchaseOrder,
//  key a.PurchaseOrderItem,
//  key a.PurchaseRequisition,
  key a.CompanyCode,
//  key a.PurchaseRequisitionItem,
  key b.PurchasingHistoryDocument,
  key b.PurchasingHistoryDocumentItem,
  key c.MaterialDocument,
  key c.MaterialDocumentItem,
  key c.MaterialDocumentYear,
  
  
  
      a.Material,
      a.PurchaseOrderItemText,
      d.PurchasingOrganization,
      d.Plant,
      d.PurReqCreationDate,
//      c.PostingDate,
b.PostingDate,
//      c.QuantityInEntryUnit,
b.Quantity,
      c.InspectionLotUsageDecisionCode,
      d.PurchaseRequisitionType,
      d.DeliveryDate,
      d.MaterialPlannedDeliveryDurn,
      d.PurchaseRequisitionStatus,
      d.MaterialGroup,
      a.OrderQuantity,
      d.RequestedQuantity

  

 
 
}
//where a.PurchaseRequisition is not initial
where d.PurchaseRequisition is not initial 


union

select from I_PurchaseRequisitionAPI01 as e
  left outer join I_PurchaseRequisitionItemAPI01 as d
    on e.PurchaseRequisition = d.PurchaseRequisition
    
  left outer join I_PurchaseOrderItemAPI01 as a
    on  a.PurchaseRequisition = d.PurchaseRequisition
    and a.PurchaseRequisitionItem = d.PurchaseRequisitionItem
    
  left outer join I_PurchaseOrderHistoryAPI01 as b
    on  b.PurchaseOrder = a.PurchaseOrder
    and b.PurchaseOrderItem = a.PurchaseOrderItem
    and b.PurchasingHistoryCategory = 'E'
    
   
  left outer join ZMM_INDGRN_REPORT1 as c
    on  c.PurchaseOrder = a.PurchaseOrder
    and c.PurchaseOrderItem = a.PurchaseOrderItem
       and c.MaterialDocument =b.PurchasingHistoryDocument
                                                         and c.MaterialDocumentItem = b.PurchasingHistoryDocumentItem
                                                         and c.MaterialDocumentYear = b.PurchasingHistoryDocumentYear



{
//  key a.PurchaseOrder,
//  key a.PurchaseOrderItem,
//  key d.PurchaseRequisition,
  /* PO Keys */
  key coalesce( a.PurchaseOrder, 'NA' )       as PurchaseOrder,
  key coalesce( a.PurchaseOrderItem, '0000' ) as PurchaseOrderItem,

  /* PR Keys */
  key d.PurchaseRequisition,
  key d.PurchaseRequisitionItem,
  key a.CompanyCode,
//  key d.PurchaseRequisitionItem,
  key b.PurchasingHistoryDocument,
  key b.PurchasingHistoryDocumentItem,
  
    key c.MaterialDocument,
  key c.MaterialDocumentItem,
  key c.MaterialDocumentYear,
  a.Material,
  a.PurchaseOrderItemText,
  d.PurchasingOrganization,
  d.Plant,
  d.PurReqCreationDate,
 //      c.PostingDate,
b.PostingDate,
//      c.QuantityInEntryUnit,
b.Quantity,
  c.InspectionLotUsageDecisionCode,
  d.PurchaseRequisitionType,
  d.DeliveryDate,
  d.MaterialPlannedDeliveryDurn,
  d.PurchaseRequisitionStatus,
  d.MaterialGroup,
  a.OrderQuantity,
  d.RequestedQuantity
}

//where a.PurchaseRequisition is not initial
where d.PurchaseRequisition is not initial
