require 'benchmark'
require 'json'

str_json = "{\"result\":{\"success\":\"1\",\"orders\":{\"paging\":{\"total\":\"1\",\"page\":\"1\",\"pages\":\"1\",\"per_page\":\"20\"},\"order\":{\"order_no\":\"123-456-789\",\"total\":\"12.12\",\"shipping\":\"3.50\",\"max_shipping_date\":\"2010-01-01 20:15:00\",\"payment\":\"CC\",\"status\":\"pending\",\"invoice_no\":\"123456\",\"comment_client\":\"Ich freu mich so sehr!\",\"comment_merchant\":\"Beim Lieferanten bestellt\",\"created\":\"2010-01-01 20:15:00\",\"client\":{\"client_id\":\"1\",\"gender\":\"Herr\",\"first_name\":\"Max\",\"last_name\":\"Mustermann\",\"company\":\"Muster GmbH\",\"street\":\"Musterstra\\u00dfe\",\"street_no\":\"1\",\"address_add\":\"Seiteneingang\",\"zip_code\":\"11111\",\"city\":\"Musterstadt\",\"country\":\"DE\",\"email\":\"max@mustermann.de\",\"phone\":\"123456-4555\"},\"delivery_address\":{\"gender\":\"Herr\",\"first_name\":\"Max\",\"last_name\":\"Mustermann\",\"company\":\"Muster GmbH\",\"street\":\"Musterstra\\u00dfe\",\"street_no\":\"1\",\"address_add\":\"Seiteneingang\",\"zip_code\":\"11111\",\"city\":\"Musterstadt\",\"country\":\"DE\"},\"items\":{\"item\":{\"item_id\":\"1\",\"product_id\":\"1\",\"variant_id\":\"5\",\"product_art_no\":\"ART-99\",\"name\":\"Musterprodukt\",\"name_add\":\"Gr\\u00fcn\",\"qty\":\"2\",\"price\":\"10.00\",\"price_sum\":\"20.00\",\"tax\":\"1\"}},\"coupon\":{\"coupon_id\":\"1\",\"total\":\"10.00\",\"code\":\"ABCDEFG\",\"comment\":\"Neukunde\"}}}}}"
str_xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<result>\n  <success>1</success>\n  <orders>\n    <paging>\n      <total>1</total>\n      <page>1</page>\n      <pages>1</pages>\n      <per_page>20</per_page>\n    </paging>\n    <order>\n      <order_no>123-456-789</order_no>\n      <total>12.12</total>\n      <shipping>3.50</shipping>\n      <max_shipping_date>2010-01-01 20:15:00</max_shipping_date>\n      <payment>CC</payment>\n      <status>pending</status>\n      <invoice_no>123456</invoice_no>\n      <comment_client>Ich freu mich so sehr!</comment_client>\n      <comment_merchant>Beim Lieferanten bestellt</comment_merchant>\n      <created>2010-01-01 20:15:00</created>\n      <client>\n        <client_id>1</client_id>\n        <gender>Herr</gender>\n        <first_name>Max</first_name>\n        <last_name>Mustermann</last_name>\n        <company>Muster GmbH</company>\n        <street>Musterstraße</street>\n        <street_no>1</street_no>\n        <address_add>Seiteneingang</address_add>\n        <zip_code>11111</zip_code>\n        <city>Musterstadt</city>\n        <country>DE</country>\n        <email>max@mustermann.de</email>\n        <phone>123456-4555</phone>\n      </client>\n      <delivery_address>\n        <gender>Herr</gender>\n        <first_name>Max</first_name>\n        <last_name>Mustermann</last_name>\n        <company>Muster GmbH</company>\n        <street>Musterstraße</street>\n        <street_no>1</street_no>\n        <address_add>Seiteneingang</address_add>\n        <zip_code>11111</zip_code>\n        <city>Musterstadt</city>\n        <country>DE</country>\n      </delivery_address>\n      <items>\n        <item>\n          <item_id>1</item_id>\n          <product_id>1</product_id>\n          <variant_id>5</variant_id>\n          <product_art_no>ART-99</product_art_no>\n          <name>Musterprodukt</name>\n          <name_add>Grün</name_add>\n          <qty>2</qty>\n          <price>10.00</price>\n          <price_sum>20.00</price_sum>\n          <tax>1</tax>\n        </item>\n      </items>\n      <coupon>\n        <coupon_id>1</coupon_id>\n        <total>10.00</total>\n        <code>ABCDEFG</code>\n        <comment>Neukunde</comment>\n      </coupon>\n    </order>\n  </orders>\n</result>\n"
parsed_resp = {"result"=>
  {"success"=>"1",
   "orders"=>
    {"paging"=>{"total"=>"1", "page"=>"1", "pages"=>"1", "per_page"=>"20"},
     "order"=>
      {"order_no"=>"123-456-789",
       "total"=>"12.12",
       "shipping"=>"3.50",
       "max_shipping_date"=>"2010-01-01 20:15:00",
       "payment"=>"CC",
       "status"=>"pending",
       "invoice_no"=>"123456",
       "comment_client"=>"Ich freu mich so sehr!",
       "comment_merchant"=>"Beim Lieferanten bestellt",
       "created"=>"2010-01-01 20:15:00",
       "client"=>
        {"client_id"=>"1",
         "gender"=>"Herr",
         "first_name"=>"Max",
         "last_name"=>"Mustermann",
         "company"=>"Muster GmbH",
         "street"=>"Musterstraße",
         "street_no"=>"1",
         "address_add"=>"Seiteneingang",
         "zip_code"=>"11111",
         "city"=>"Musterstadt",
         "country"=>"DE",
         "email"=>"max@mustermann.de",
         "phone"=>"123456-4555"},
       "delivery_address"=>
        {"gender"=>"Herr",
         "first_name"=>"Max",
         "last_name"=>"Mustermann",
         "company"=>"Muster GmbH",
         "street"=>"Musterstraße",
         "street_no"=>"1",
         "address_add"=>"Seiteneingang",
         "zip_code"=>"11111",
         "city"=>"Musterstadt",
         "country"=>"DE"},
       "items"=>
        {"item"=>
          {"item_id"=>"1",
           "product_id"=>"1",
           "variant_id"=>"5",
           "product_art_no"=>"ART-99",
           "name"=>"Musterprodukt",
           "name_add"=>"Grün",
           "qty"=>"2",
           "price"=>"10.00",
           "price_sum"=>"20.00",
           "tax"=>"1"}},
       "coupon"=>{"coupon_id"=>"1", "total"=>"10.00", "code"=>"ABCDEFG", "comment"=>"Neukunde"}}}}}

Benchmark.bm(10) do |b|
  b.report("string json") { 1_000_000.times { d = JSON.dump(str_json); JSON.load(d) } }
  b.report("string xml") { 1_000_000.times { d = JSON.dump(str_xml); JSON.load(d) } }
  b.report("parsed xml") { 1_000_000.times { d = JSON.dump(parsed_resp); JSON.load(d) } }
end

