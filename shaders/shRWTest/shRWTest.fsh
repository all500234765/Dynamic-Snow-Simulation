struct PS {
    float4 Position : SV_Position0;
    float2 Texcoord : TEXCOORD0;
    uint inst       : SV_InstanceID;
};

float4 main(PS In) : SV_Target0 {
    return (1.).xxxx;
}

