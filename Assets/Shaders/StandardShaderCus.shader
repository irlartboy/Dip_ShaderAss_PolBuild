Shader "Custom/StandardShaderCus"
{
  Properties {
_Color ("Color", Color) = (1,1,1,1)
_Glossiness ("Smoothness", Range(0,1)) = 0.5
_Metallic ("Metallic", Range(0,1)) = 0.0
}
SubShader {
Tags { "RenderType"="Opaque" }
LOD 200

CGPROGRAM
// Physically based Standard lighting model, and enable shadows on all light types
#pragma surface surf Standard fullforwardshadows
// Use shader model 3.0 target, to get nicer looking lighting
#pragma target 3.0

float4 _AmbientColor;
float _MySliderValue;

struct Input { 
	float2 uv_MainTex;
	};

half _Glossiness;
half _Metallic;
fixed4 _Color;

void surf (Input IN, inout SurfaceOutputStandard o) { fixed4 c = pow((_Color + _AmbientColor), _MySliderValue);
o.Albedo = c.rgb; 

o.Metallic = _Metallic;
o.Smoothness = _Glossiness;
o.Alpha = c.a;
}
ENDCG
}
FallBack "Diffuse"
}




