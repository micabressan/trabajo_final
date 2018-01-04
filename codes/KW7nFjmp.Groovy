apply plugin: 'com.android.application'


android {

    ...

    buildTypes {

        debug {
        }

        release {
           
        }

    }

    flavorDimensions "type", "color"

    productFlavors {

        /**
         * Type
         */
        Type1 {
            dimension "type"
        }
        Type2 {
            dimension "type"
        }
        Type3 {
            dimension "type"
        }


        /**
         * Color
         */
        Blue {
            dimension "color"
        }

        Green {
            dimension "color"
        }

        Red {
            dimension "color"
        }
    }

    ...

}

dependencies {

  ...
}