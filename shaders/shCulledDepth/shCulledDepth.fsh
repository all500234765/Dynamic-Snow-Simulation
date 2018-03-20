struct PS {
    float4 Position : SV_Position0;
    float  Depth    : TEXCOORD1;
    float  Clip     : TEXCOORD0;
};

float4 main(PS In) : SV_Target0 {
    clip( In.Clip );
    return float4(In.Depth.xxx, 1.);
}
