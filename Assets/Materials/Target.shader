Shader "Test/Target" 
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
    }

	CGINCLUDE

	#include "UnityCG.cginc"
	#include "UnityLightingCommon.cginc"

    half4 _Color;

    struct v2f
    {
        fixed4 diff : COLOR0;
        float4 vertex : SV_POSITION;            
		float3 worldPos : TEXCOORD0;
	};

    v2f vert (appdata_base v)
    {
        v2f o;
        o.vertex = UnityObjectToClipPos(v.vertex);
        half3 worldNormal = UnityObjectToWorldNormal(v.normal);
        half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
        o.diff = nl * _LightColor0;
		o.worldPos = mul (unity_ObjectToWorld, v.vertex);
        return o;
    }

    fixed4 frag_0 (v2f i) : SV_Target
    {
        fixed4 col = _Color;
        col.rgb *= i.diff;
		col.a = step(i.worldPos.z, 0);
        return col;
    }

    fixed4 frag_1 (v2f i) : SV_Target
    {
        fixed4 col = _Color;
        col.rgb *= i.diff;
        return col;
    }

	ENDCG

    SubShader
    {
		Tags 
		{ 
			"RenderType"="Transparent" 
			"Queue"="Transparent+1" 
			"LightMode"="ForwardBase"
		}

		Pass
		{
            Stencil
			{
                Ref 0
                Comp Equal
            }
            
			Blend SrcAlpha OneMinusSrcAlpha 

            CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag_0
			ENDCG
		}
        
        Pass
        {
            Stencil
			{
                Ref 1
                Comp Equal
            }
            
			ZTest Always
			Blend SrcAlpha OneMinusSrcAlpha 

            CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag_1
            ENDCG
		}

	}

}