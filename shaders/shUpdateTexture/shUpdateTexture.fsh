struct PS {
    float4 Position : SV_Position0;
    float2 Texcoord : TEXCOORD0;
};

float4 main(PS In) : SV_Target0 {
    float4 Out = gm_BaseTextureObject.Sample(gm_BaseTexture, In.Texcoord);
    
    //Out.r = lerp(Out.r, max(0., Out.r - .001), .1);
    
    return Out;
}

