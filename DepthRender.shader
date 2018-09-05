Shader "GHB/DepthRender"
{
	 Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Color("Color" ,color) = (1,1,1,1)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			sampler2D _CameraDepthTexture;
			float4 _MainTex_ST;
			fixed4 _Color;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float depth = UNITY_SAMPLE_DEPTH(tex2D(_CameraDepthTexture, i.uv));
				float linear01Depth = Linear01Depth(depth);
				fixed4 col = tex2D(_MainTex , i.uv);
				linear01Depth = max (.1 , linear01Depth);
				// fixed4 rr =  smoothstep(0,1, col +  (5 * linear01Depth ));
				return col + linear01Depth * _Color;
			}

			ENDCG
		}
	}
}
