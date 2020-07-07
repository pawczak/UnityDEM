﻿Shader "Custom/ElevationLevelFadedShader"
{
    Properties
    {
            _minHeight("MinHeight", Float) = 0 
        _maxHeight("MaxHeight", Float) = 1000 
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType" = "Transparent" }
        Lighting Off
        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha
        LOD 100

            CGPROGRAM
            #pragma surface surf Unlit alpha:fade
            #pragma target 3.0
            
            half _minHeight;
            half _maxHeight;

            sampler2D _MainTex;
            half4 _MainTex_ST;

            struct Input
            {
                half3 worldPos;
                 float2 custom_uv; // cannot start with "uv"
            };
            
            half4 LightingUnlit (SurfaceOutput s, half3 lightDir, half atten) 
            {
               half4 c;
               c.rgb = s.Albedo;
               c.a = s.Alpha;
               return c;
            }
    
            half inverseLerp(half a,half b, half value)
            {
                return saturate((value-a)/(b-a));
            }
            
            void vert (inout appdata_full v, out Input o)
            {
                // copy the unmodified texture coordinates (aka UVs)
                o.custom_uv = v.texcoord.xy;
            }
 
    
            void surf (Input IN, inout SurfaceOutput o)
            {  
                float2 uv = TRANSFORM_TEX(IN.custom_uv, _MainTex);
                
                half heightPercent = inverseLerp(_minHeight,_maxHeight, IN.worldPos.y);
                o.Albedo = tex2D(_MainTex, heightPercent);
                o.Alpha = tex2D(_MainTex, heightPercent);
            }
            ENDCG
        
    }
}
