struct VS {
    float4 Position : POSITION0;
    float2 Texcoord : TEXCOORD0;
    float3 Normal   : NORMAL0;
};

struct PS {
    float4 Position : SV_Position0;
    float2 Texcoord : TEXCOORD0;
    float3 Normal   : NORMAL0;
    float  Color    : TEXCOORD1;
};

float _Time;

Texture2D<float> _Displacement : register(t0);
SamplerState _DisplacementSamp : register(s0);

float Sample(Texture2D<float> t, SamplerState s, float2 uv) { // Blur a little bit
    float b = 0.;
    int c = 0;
    
    for( int i = -20; i <= 20; i++ ) {
        for( int j = -20; j <= 20; j++ ) {
            b += t.SampleLevel(s, uv + float2(i, j) / 1024., 0);
            c++;
        }
    }
    
    return b / float(c);
}

[patchsize(12)]
PS main(VS In) {
    float2 uv = float2(In.Texcoord.yx);
    uv.y = 1. - uv.y;
    
    float disp = Sample(_Displacement, _DisplacementSamp, uv);
    float d = disp * 255.;
    In.Position.xyz += In.Normal * (1. - d);
    In.Normal.z -= disp * 100.;
    
    PS Out;
        Out.Position = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], In.Position);
        Out.Normal   = normalize(mul(gm_Matrices[MATRIX_WORLD], float4(In.Normal, 0.)));
        Out.Texcoord = In.Texcoord;
        Out.Color    = disp * 2.;
    return Out;
}
