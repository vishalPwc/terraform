---
swagger: "2.0"
info:
  title: ${api_gw_spec_title}
  description: Ecom API Gateway
  version: 1.0.0
schemes:
  - https
paths:
  /search/v1/autoSuggest:
    get:
      produces:
        - application/json
      summary: Search Service
      operationId: search-v1
      x-google-backend:
        address: ${search_service_url}/search/v1/autoSuggest
      security:
        - api_key: []
      responses:
        "200":
          description: OK
  /search/v1/searchProducts:
    get:
      produces:
        - application/json
      summary: Search Products Service
      operationId: search-products-v1
      x-google-backend:
        address: ${search_service_url}/search/v1/searchProducts
      security:
        - service-atg: []
        - service-mobile: []
        - service-commerce-tools: []
      responses:
        "200":
          description: OK        
  /search/v1/ub/ubProduct:
    get:
      produces:
        - application/json
      summary: Uniform Builder Products
      operationId: uniform-builder-v1
      x-google-backend:
        address: ${search_service_url}/search/v1/ub/ubProduct
      security:
        - api_key: []
      responses:
        "200":
          description: OK                
  /store/v1/searchStores:
    post:
      consumes:
        - application/json
      parameters: 
        - in: body
          name: grid 
          schema: 
            type: object 
            required: 
              - latitude 
              - longitude 
            properties: 
              latitude: 
                type: string 
              longitude: 
                type: string        
      summary: Store Service
      operationId: store-v1
      x-google-backend:
        address: ${store_service_url}/store/v1/searchStores
      security:
        - service-atg: []
        - service-mobile: []
        - service-commerce-tools: []
      responses:
        "200":
          description: OK
  /price/v1/getItemPrice/skudIds/{skuIds}/storeIds/{storeIds}:
    get:
      parameters:
        - in: "path"
          name: skuIds
          required: true
          type: string      
        - in: "path"
          name: storeIds
          required: true
          type: string            
      produces:
        - application/json
      summary: Price Service for skus and stores
      operationId: price-sku-store-v1
      x-google-backend:
        address: ${price_service_url}
        path_translation: APPEND_PATH_TO_ADDRESS
      security:
        - service-atg: []
        - service-mao: []
        - service-commerce-tools: []
      responses:
        "200":
          description: OK          
  /price/v1/getItemPrice/skudIds/{skuIds}:
    get:
      parameters:
        - in: "path"
          name: skuIds
          required: true
          type: string      
      produces:
        - application/json
      summary: Price Service for skus
      operationId: price-sku-v1
      x-google-backend:
        address: ${price_service_url}
        path_translation: APPEND_PATH_TO_ADDRESS
      security:
        - service-atg: []
        - service-mao: []
        - service-commerce-tools: []
      responses:
        "200":
          description: OK
  /staticContent/v1/readAssets:
    post:
      consumes:
        - application/json
      parameters: 
        - in: body
          name: content 
          schema: 
            type: object 
            required: 
              - contentDetails 
            properties: 
              contentDetails: 
                type: object
                required:
                - siteId
                - assetPath
                description: nested object
                properties:
                  siteId:
                    type: string
                  assetPath:
                    type: string                
      summary: Content Service
      operationId: content-v1
      x-google-backend:
        address: ${content_service_url}/staticContent/v1/readAssets
      security:
        - service-atg: []
        - service-commerce-tools: []
      responses:
        "200":
          description: OK
  /order/v1/coupon/markclaimed/{couponCode}:
    get:
      parameters:
        - in: "path"
          name: couponCode
          required: true
          type: string                 
      produces:
        - application/json
      summary: Order Claim Coupon
      operationId: order-claim-coupon-v1
      x-google-backend:
        address: ${order_service_url}
        path_translation: APPEND_PATH_TO_ADDRESS
      security:
        - service-atg: []
        - service-mao: []
        - service-commerce-tools: []
      responses:
        "200":
          description: OK  
  /order/v1/sfl/list/{customerID}:
    get:
      parameters:
        - in: "path"
          name: customerID
          required: true
          type: string                 
      produces:
        - application/json
      summary: Order SFL List Customer
      operationId: order-sfl-list-customer-v1
      x-google-backend:
        address: ${order_service_url}
        path_translation: APPEND_PATH_TO_ADDRESS
      security:
        - service-atg: []
        - service-mao: []
        - service-commerce-tools: []
      responses:
        "200":
          description: OK  
  /order/v1/sfl/{customerID}/delete/{itemID}:
    get:
      parameters:
        - in: "path"
          name: customerID
          required: true
          type: string     
        - in: "path"
          name: itemID
          required: true
          type: string                         
      produces:
        - application/json
      summary: Order SFL Customer Delete Item
      operationId: order-sfl-customer-delete-item-v1
      x-google-backend:
        address: ${order_service_url}
        path_translation: APPEND_PATH_TO_ADDRESS
      security:
        - service-atg: []
        - service-mao: []
        - service-commerce-tools: []
      responses:
        "200":
          description: OK  
  /order/v1/cancel:
    get:
      parameters:
        - in: "query"
          name: orderId
          required: true
          type: string          
      summary: Order cancel
      operationId: order-cancel-v1
      x-google-backend:
        address: ${order_service_url}
        path_translation: APPEND_PATH_TO_ADDRESS
      security:
        - service-atg: []
        - service-mobile: []
        - service-commerce-tools: []
      responses:
        "200":
          description: OK    
  /order/v1/list:
    post:      
      consumes:
        - application/json
      parameters: 
        - in: body
          name: orderlist 
          schema: 
            type: object           
      summary: Order List
      operationId: order-list-v1
      x-google-backend:
        address: ${order_service_url}/order/v1/list
      security:
        - service-atg: []
        - service-mobile: []
        - service-commerce-tools: []
      responses:
        "200":
          description: OK
  /order/v1/claims/request:
    post:  
      consumes:
        - application/json
      parameters: 
        - in: body
          name: claimrequest 
          schema: 
            type: object       
      summary: order cleaims request
      operationId: order-claim-request-v1
      x-google-backend:
        address: ${order_service_url}/order/v1/claims/request
      security:
        - service-atg: []
        - service-mobile: []
        - service-commerce-tools: []
      responses:
        "200":
          description: OK
  /order/v1/applypromotions:
    post:     
      consumes:
        - application/json
      parameters: 
        - in: body
          name: applypromo 
          schema: 
            type: object       
      summary: Order Apply Promotion
      operationId: order-apply-promo-v1
      x-google-backend:
        address: ${order_service_url}/order/v1/applypromotions
      security:
        - service-atg: []
        - service-mobile: []
        - service-commerce-tools: []
        - service-mao: []
      responses:
        "200":
          description: OK
  /order/v1/sfl/add:
    post:
      consumes:
        - application/json
      parameters:
        - in: body
          name: sfladd
          schema:
            type: object
      summary: Order SFL add
      operationId: order-sfl-add-v1
      x-google-backend:
        address: ${order_service_url}/order/v1/sfl/add
      security:
        - service-atg: []
        - service-mobile: []
        - service-commerce-tools: []
        - service-mao: []
      responses:
        "200":
          description: OK
  /profile/v1/validate/{id}:
    get:
      parameters:
        - in: "path"
          name: id
          required: true
          type: string
      produces:
        - application/json
      summary: Profile Service
      operationId: profile-v1
      x-google-backend:
        address: ${profile_service_url}
        path_translation: APPEND_PATH_TO_ADDRESS
      security:
        - service-mao: []
        - service-atg: []
        - service-commerce-tools: []
      responses:
        "200":
          description: OK          
  /akamai/sureroute-test-object.html:
    get:
      produces:
        - text/html
      summary: AkamaiHealthCheck
      operationId: akamai
      x-google-backend:
        address: ${akamai_service_url}/akamai/sureroute-test-object.html
      responses:
        "200":
          description: OK
          schema:
            type: string
securityDefinitions:
  api_key:
    type: apiKey
    name: x-api-key
    in: header
  service-mao:
    authorizationUrl: ""
    flow: implicit
    type: oauth2
    x-google-issuer: ${service_mao_sa}
    x-google-jwks_uri: https://www.googleapis.com/robot/v1/metadata/x509/${service_mao_sa}
  service-atg:
    authorizationUrl: ""
    flow: implicit
    type: oauth2
    x-google-issuer: ${service_atg_sa}
    x-google-jwks_uri: https://www.googleapis.com/robot/v1/metadata/x509/${service_atg_sa}
  service-commerce-tools:
    authorizationUrl: ""
    flow: implicit
    type: oauth2
    x-google-issuer: ${service_commerce_tools_sa}
    x-google-jwks_uri: https://www.googleapis.com/robot/v1/metadata/x509/${service_commerce_tools_sa}
  service-mobile:
    authorizationUrl: ""
    flow: implicit
    type: oauth2
    x-google-issuer: ${service_mobile_sa}
    x-google-jwks_uri: https://www.googleapis.com/robot/v1/metadata/x509/${service_mobile_sa}
