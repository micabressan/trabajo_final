this.coinGroup              = game.add.group();
this.coinGroup.enabledBody  = true;
this.map.createFromObjects  ('LayerObject', 4, 'ImageCoin', 0, true, false, this.coinGroup);