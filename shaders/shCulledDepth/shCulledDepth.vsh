struct VS {
    float4 Position : POSITION0;
    float2 Texcoord : TEXCOORD0;
};

struct PS {
    float4 Position : SV_Position0;
    float  Depth    : TEXCOORD1;
    float  Clip     : TEXCOORD0;
};

static const float _z = 0., z = 30.;

float _WUT;

PS main(VS In) {
    float4 P = mul(mul(gm_Matrices[MATRIX_WORLD], gm_Matrices[MATRIX_PROJECTION]), In.Position);
    
    PS Out;
        Out.Position = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], In.Position);
        Out.Clip     = ( (P.z - z) <= _z ? 1. : -1. ); // 1 - show, -1 - discard
        Out.Depth    = abs((P.z - z) / 255.); // Write normalized depth value
        
        Out.Clip = _WUT ? -Out.Clip : Out.Clip; // Flip
    return Out;
}
