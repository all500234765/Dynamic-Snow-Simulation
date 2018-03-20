struct VS {
    float4 Position : POSITION0;
    float2 Texcoord : TEXCOORD0;
    uint inst       : SV_InstanceID;
};

struct PS {
    float4 Position : SV_Position0;
    float2 Texcoord : TEXCOORD0;
    uint inst       : SV_InstanceID;
};

float _Time;

PS main(VS In) {
    In.Position.x += 100. * In.inst;
    
    PS Out;
        Out.Position = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], In.Position);
        Out.Texcoord = In.Texcoord;
        Out.inst     = In.inst;
    return Out;
}
