Shader "Test/Mask" 
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags 
		{ 
			"RenderType"="Transparent" 
			"Queue"="Transparent" 
		}

        Pass
        {
            Stencil
			{
                Ref 1
                Comp always
                Pass replace
            }

            Tags { "LightMode"="ForwardBase" }

            ZWrite On
			ZTest LEqual
			Blend SrcAlpha OneMinusSrcAlpha 

            CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
            
			#include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc"

            struct v2f
            {
                fixed4 diff : COLOR0;
                float4 vertex : SV_POSITION;            
			};

            half4 _Color;
            
            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                half3 worldNormal = UnityObjectToWorldNormal(v.normal);
                half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
                o.diff = nl * _LightColor0;
                return o;  
			}
            
            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = _Color;
                col.rgb *= i.diff;
                return col;
            }
            ENDCG
        }
    }
}