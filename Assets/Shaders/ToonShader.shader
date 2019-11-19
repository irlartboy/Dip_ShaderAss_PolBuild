Shader "Custom/ToonShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
		_RampTex ("Ramp", 2D) = "white" {}
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

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

      

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }

		fixed4 LightingToon (SurfaceOut s, fixed3 lightDir, fixed atten)
		// calculate the dot product of the light dir and the surface normal
		half NdotL = dot(s.Normal,lightDir);
		// remap NdorL to value of ramp map
		NdotL = tex2D(_RampTex, fixed2(NdotL, 0.5));

		// set the colour
		half4 color;

		color.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
		color.a =s.Alpha;

		// return calc colour
		return color;

        ENDCG
    }
    FallBack "Diffuse"
}
