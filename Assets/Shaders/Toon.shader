Shader "Custom/Toon"
{
    Properties
    {
       _MainTex("Texture", 2D) = "white"
	   _RampTex("Ramp", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM

        #pragma surface surf Toon

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
		sampler2D _RampTex;

        struct Input
        {
            float2 uv_MainTex;
        };

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		}
   
		fixed4 LightingToon(SurfaceOutput s, fixed3 lightDir, fixed atten)
		{
			//calculate the dot product of the light direction and the surfaces normal
			half NdotL = dot(s.Normal, lightDir);

			// remap ndotl to the value on the ramp map
			NdotL = tex2D(_RampTex, fixed2(NdotL, 0.5));

			// set what color should be returned
			half4 color;
			color.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
			color.a = s.Alpha;

			// return the calculated colour
			return color;
		}
		
        
        ENDCG
    }
    FallBack "Diffuse"
}
