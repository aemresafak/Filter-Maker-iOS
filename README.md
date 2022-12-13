# Filter-Maker-iOS
Filter Maker is an iOS project that helps its users create re-usable filters. Users can choose among 15+ filter types to create their own custom filters.
Go to the bottom to check the technical details.

### Filters Supported
- Brightness
- Contrast
- Saturation
- Exposure
- Vibrance
- White Balance
- Gamma
- Highlights and Shadows
- Sepia Tone
- Tint
- Highlight Tint
- Shadow Tint
- Vignette
- Secondary Vignette
- RGB Colors Adjustment
- Contrast Limited Adaptive Histogram Equalization
- RGB Levels Adjustment
- Grain
- Infrared

<img src="https://user-images.githubusercontent.com/59789023/200592001-75925a99-eca4-4b71-8cc5-c2045373a720.jpeg" width="30%">  <img src="https://user-images.githubusercontent.com/59789023/200593904-c1edf98f-48e6-47f9-8d4c-33a1146e9a52.jpeg" width="30%">


### Each filter comes with its custom UI

###### Brightness:
<img src="https://user-images.githubusercontent.com/59789023/207395325-81656fcd-1803-4337-aa4e-6f9711c65ce5.png" width="30%">

###### WhiteBalance:
<img src="https://user-images.githubusercontent.com/59789023/207395625-c281f4de-902e-42c9-af29-a02ddaddf643.png" width="30%">


###### Tint:
<img src="https://user-images.githubusercontent.com/59789023/207395770-4830d60c-bf99-4abd-b30f-60a983763209.png" width="30%">

###### Vignette:
<img src="https://user-images.githubusercontent.com/59789023/207395781-90e89ee0-df9e-4cc9-9497-69f931ee68d8.png" width="30%">

###### RGB Colors Adjustment:
<img src="https://user-images.githubusercontent.com/59789023/207395796-84efe7db-548d-4796-8aa5-3e751912eab6.png" width="30%">


###### CLAHE:
<img src="https://user-images.githubusercontent.com/59789023/207395817-c15a595f-2501-4126-b412-f54421945ba3.png" width="30%">


###### RGBLevelsAdjustment
<img src="https://user-images.githubusercontent.com/59789023/207395834-bab65f0b-3721-4a98-8f1a-babc2b4b6d75.png" width="30%"> <img src="https://user-images.githubusercontent.com/59789023/207395855-e003ee54-f66c-456f-8b38-5108bb5e8100.png" width="30%">


### Other Features
###### Filters can be shared between users
- Users can share their filters by clicking Copy Filter To Clipboard method. This method copies the filter as JSON data. Users that want to import the filter can copy the json data and use import feature of the app to copy filter.

<img src="https://user-images.githubusercontent.com/59789023/207396795-3184e0a1-1d3e-4cf1-9b3b-980ba9922085.png" width="30%"> <img src="https://user-images.githubusercontent.com/59789023/207396834-cd96fa5a-24fe-413e-bbdc-f92ae9700639.png" width="30%">


###### User can use their filter to filter any photo in their library and can save the filtered photo to their library.
<img src="https://user-images.githubusercontent.com/59789023/207396988-5a047bbe-11d0-4346-9dfc-34e5def94231.png" width="30%">


### Technical Details
  This project is mostly implemented using Swift programming language and SwiftUI library. For implementing filters, MetalPetal library was used. Some custom filters were created using Metal programming language. This project follows MVVM architecture standards, each screen comes with its ViewModel.
 
###### Some of the Other Concepts in This Project
- Permission Handling (For accessing and writing to PhotosLibrary)
- Creating custom views from scratch
- Codable protocol, saving filters as JSON to internal storage
  

