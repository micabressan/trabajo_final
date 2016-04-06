import com.google.gson.annotations.SerializedName;
 
public class JsonRpcABCRequest {
 @SerializedName("propertyA")
 private String pA = "valueA";

 @SerializedName("propertyB")
 private String pB = "valueB";
}

new Gson().toJson(new JsonRpcABCRequest())