struct PS {
    float4 Position : SV_Position0;
    float2 Texcoord : TEXCOORD0;
    float3 Normal   : NORMAL0;
    float  Color    : TEXCOORD1;
};

/*Texture2D<float4> _Displacement : register(t1);
SamplerState _DisplacementSamp : register(s1);*/

Texture2D<float3> _Texture : register(t1);
SamplerState _TextureSampl : register(s1);

float4 main(PS In) : SV_Target0 {
    float2 uv = float2(In.Texcoord.yx);
    uv.y = 1. - uv.y;
    
    float4 Out = float4(In.Texcoord, 0., 1.); //*/float4(_Displacement.Load(uint3(uv * 1024., 0)).xxx, 1.);
    float b = distance(uv, (.5).xx); //max(.5, dot(In.Normal, normalize(float3(0., 0., 0.))));
    
    return float4(_Texture.Sample(_TextureSampl, uv) * (1. - In.Color), 1.);
    //float4(/*float3(In.Color.xx, .8) */ In.Normal * .5 + .5, 1.); //float4(b * (In.Normal * .5 + .5), 1.);
}
