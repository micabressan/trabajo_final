  '2':
    material: 351
    data: 10
    slot: 28
    update: true
    hide_enchantments: true
    enchantments:
    - 'DURABILITY;1'
    display_name: '&e&l&nVIP'
    lore:
    - '&d•*´¨`*•.¸¸.•*´¨`*•.¸¸.•*´¨`*•.¸¸.•*´¨`*•.¸¸.•'
    - '&a'
    - '&eRank: &fVIP'
    - '&eTime: &f7 วัน'
    - '&e'
    - '&a» สิ่งที่คุณต้องมี ถึงจะสามารถชื้อยศนี้ได้'
    - '&e❖ Coins: &f5,000 &e⛁'
    - ''
    - '&9» สิ่งที่คุณจะได้รับ เมือชื้อยศนี้แล้ว'
    - '&d✎ &fสามารถใช้ เอฟเฟค หรือ ของเล่นต่างๆ ใน ล็อกบี้ ได้'
    - '&d✎ &fสามารถใช้ Kit หรือ ไอเท็ม ต่างๆ ในมินิเกมได้'
    - '&d✎ &fสามารถ บิน ได้ใน ล็อกบี้'
    - '&d✎ &fสามารถ เปิดกล่อง 1 - 4 &e✯ ดาว &fได้'
    - ''
    - '&a>> &c&nคลิกเพื่อทำการชื้อ &a<<'
    - ''
    - '&d¸.•*´¨`*•.¸¸.•*´¨`*•.¸¸.•*´¨`*•.¸¸.•*´¨`*•.¸'
    left_click_commands:
    - '[console] sendsubtitle 1 5 3 &aThis is an &e&lAmazing'
    - '[console] eco take %player_name% 80'
    left_click_requirement:
      requirements:
        Money:
          type: has money
          amount: 5000.0
      deny_commands:
      - '[close]'
      - '[message] &6&lDeluxe&eMenu &7»&f You do not have enough money to buy.'