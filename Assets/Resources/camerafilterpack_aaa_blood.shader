Shader "CameraFilterPack/AAA_Blood" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_MainTex2 ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 38900
			Program "vp" {
				SubProgram "d3d11 " {
					"!!vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec2 _MainTex_TexelSize;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					 vec4 phase0_Output0_0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlatb0 = _MainTex_TexelSize.y<0.0;
					    u_xlat2 = (-in_TEXCOORD0.y) + 1.0;
					    phase0_Output0_0.w = (u_xlatb0) ? u_xlat2 : in_TEXCOORD0.y;
					    phase0_Output0_0.xyz = in_TEXCOORD0.xyx;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0;
					vs_TEXCOORD0 = phase0_Output0_0.xy;
					vs_TEXCOORD1 = phase0_Output0_0.zw;
					    return;
					}"
				}
				SubProgram "glcore " {
					"!!!!GL3x
					#ifdef VERTEX
					#version 150
					#extension GL_ARB_explicit_attrib_location : require
					#ifdef GL_ARB_shader_bit_encoding
					#extension GL_ARB_shader_bit_encoding : enable
					#endif
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					 vec4 phase0_Output0_0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    phase0_Output0_0 = in_TEXCOORD0.xyxy;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0;
					vs_TEXCOORD0 = phase0_Output0_0.xy;
					vs_TEXCOORD1 = phase0_Output0_0.zw;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 150
					#extension GL_ARB_explicit_attrib_location : require
					#ifdef GL_ARB_shader_bit_encoding
					#extension GL_ARB_shader_bit_encoding : enable
					#endif
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	float _Value;
					uniform 	float _Value2;
					uniform 	float _Value3;
					uniform 	float _Value4;
					uniform 	float _Value5;
					uniform 	vec4 _MainTex_ST;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex2;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat10_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1 = texture(_MainTex2, vs_TEXCOORD0.xy);
					    u_xlat2.xyz = u_xlat10_1.xyz * vec3(_Value3);
					    u_xlat2.xyz = u_xlat10_1.xyz * vec3(vec3(_Value4, _Value4, _Value4)) + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat10_1.xyz * vec3(vec3(_Value5, _Value5, _Value5)) + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * vec3(vec3(_Value2, _Value2, _Value2)) + u_xlat2.xyz;
					    u_xlat0.xy = u_xlat1.xx * vec2(0.001953125, 0.001953125) + u_xlat0.xy;
					    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_Value, _Value, _Value)) + u_xlat10_0.xyz;
					    u_xlat9 = u_xlat1.x + 1.0;
					    SV_Target0.x = u_xlat9 * u_xlat0.x;
					    SV_Target0.yz = u_xlat0.yz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					"!!vulkan
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 135
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Vertex %4 "main" %30 %58 %109 %119 %120 %123 %126 
					                                                     OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                     OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                     OpDecorate %13 ArrayStride 13 
					                                                     OpDecorate %14 ArrayStride 14 
					                                                     OpMemberDecorate %16 0 Offset 16 
					                                                     OpMemberDecorate %16 1 Offset 16 
					                                                     OpMemberDecorate %16 2 Offset 16 
					                                                     OpDecorate %16 Block 
					                                                     OpDecorate %18 DescriptorSet 18 
					                                                     OpDecorate %18 Binding 18 
					                                                     OpDecorate %30 Location 30 
					                                                     OpDecorate %58 Location 58 
					                                                     OpMemberDecorate %107 0 BuiltIn 107 
					                                                     OpMemberDecorate %107 1 BuiltIn 107 
					                                                     OpMemberDecorate %107 2 BuiltIn 107 
					                                                     OpDecorate %107 Block 
					                                                     OpDecorate %119 Location 119 
					                                                     OpDecorate %120 Location 120 
					                                                     OpDecorate vs_TEXCOORD0 Location 123 
					                                                     OpDecorate vs_TEXCOORD1 Location 126 
					                                              %2 = OpTypeVoid 
					                                              %3 = OpTypeFunction %2 
					                                              %6 = OpTypeBool 
					                                              %7 = OpTypePointer Private %6 
					                                Private bool* %8 = OpVariable Private 
					                                              %9 = OpTypeFloat 32 
					                                             %10 = OpTypeVector %9 4 
					                                             %11 = OpTypeInt 32 0 
					                                         u32 %12 = OpConstant 4 
					                                             %13 = OpTypeArray %10 %12 
					                                             %14 = OpTypeArray %10 %12 
					                                             %15 = OpTypeVector %9 2 
					                                             %16 = OpTypeStruct %13 %14 %15 
					                                             %17 = OpTypePointer Uniform %16 
					Uniform struct {f32_4[4]; f32_4[4]; f32_2;}* %18 = OpVariable Uniform 
					                                             %19 = OpTypeInt 32 1 
					                                         i32 %20 = OpConstant 2 
					                                         u32 %21 = OpConstant 1 
					                                             %22 = OpTypePointer Uniform %9 
					                                         f32 %25 = OpConstant 3,674022E-40 
					                                             %27 = OpTypePointer Private %9 
					                                Private f32* %28 = OpVariable Private 
					                                             %29 = OpTypePointer Input %15 
					                                Input f32_2* %30 = OpVariable Input 
					                                             %31 = OpTypePointer Input %9 
					                                         f32 %35 = OpConstant 3,674022E-40 
					                                             %37 = OpTypePointer Private %10 
					                              Private f32_4* %38 = OpVariable Private 
					                                             %40 = OpTypePointer Function %9 
					                                         u32 %49 = OpConstant 3 
					                                             %51 = OpTypeVector %9 3 
					                              Private f32_4* %56 = OpVariable Private 
					                                             %57 = OpTypePointer Input %10 
					                                Input f32_4* %58 = OpVariable Input 
					                                         i32 %61 = OpConstant 0 
					                                         i32 %62 = OpConstant 1 
					                                             %63 = OpTypePointer Uniform %10 
					                                         i32 %82 = OpConstant 3 
					                              Private f32_4* %86 = OpVariable Private 
					                                            %106 = OpTypeArray %9 %21 
					                                            %107 = OpTypeStruct %10 %9 %106 
					                                            %108 = OpTypePointer Output %107 
					       Output struct {f32_4; f32; f32[1];}* %109 = OpVariable Output 
					                                            %117 = OpTypePointer Output %10 
					                              Output f32_4* %119 = OpVariable Output 
					                               Input f32_4* %120 = OpVariable Input 
					                                            %122 = OpTypePointer Output %15 
					                      Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                      Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                            %129 = OpTypePointer Output %9 
					                                         void %4 = OpFunction None %3 
					                                              %5 = OpLabel 
					                               Function f32* %41 = OpVariable Function 
					                                Uniform f32* %23 = OpAccessChain %18 %20 %21 
					                                         f32 %24 = OpLoad %23 
					                                        bool %26 = OpFOrdLessThan %24 %25 
					                                                     OpStore %8 %26 
					                                  Input f32* %32 = OpAccessChain %30 %21 
					                                         f32 %33 = OpLoad %32 
					                                         f32 %34 = OpFNegate %33 
					                                         f32 %36 = OpFAdd %34 %35 
					                                                     OpStore %28 %36 
					                                        bool %39 = OpLoad %8 
					                                                     OpSelectionMerge %43 None 
					                                                     OpBranchConditional %39 %42 %45 
					                                             %42 = OpLabel 
					                                         f32 %44 = OpLoad %28 
					                                                     OpStore %41 %44 
					                                                     OpBranch %43 
					                                             %45 = OpLabel 
					                                  Input f32* %46 = OpAccessChain %30 %21 
					                                         f32 %47 = OpLoad %46 
					                                                     OpStore %41 %47 
					                                                     OpBranch %43 
					                                             %43 = OpLabel 
					                                         f32 %48 = OpLoad %41 
					                                Private f32* %50 = OpAccessChain %38 %49 
					                                                     OpStore %50 %48 
					                                       f32_2 %52 = OpLoad %30 
					                                       f32_3 %53 = OpVectorShuffle %52 %52 0 1 0 
					                                       f32_4 %54 = OpLoad %38 
					                                       f32_4 %55 = OpVectorShuffle %54 %53 4 5 6 3 
					                                                     OpStore %38 %55 
					                                       f32_4 %59 = OpLoad %58 
					                                       f32_4 %60 = OpVectorShuffle %59 %59 1 1 1 1 
					                              Uniform f32_4* %64 = OpAccessChain %18 %61 %62 
					                                       f32_4 %65 = OpLoad %64 
					                                       f32_4 %66 = OpFMul %60 %65 
					                                                     OpStore %56 %66 
					                              Uniform f32_4* %67 = OpAccessChain %18 %61 %61 
					                                       f32_4 %68 = OpLoad %67 
					                                       f32_4 %69 = OpLoad %58 
					                                       f32_4 %70 = OpVectorShuffle %69 %69 0 0 0 0 
					                                       f32_4 %71 = OpFMul %68 %70 
					                                       f32_4 %72 = OpLoad %56 
					                                       f32_4 %73 = OpFAdd %71 %72 
					                                                     OpStore %56 %73 
					                              Uniform f32_4* %74 = OpAccessChain %18 %61 %20 
					                                       f32_4 %75 = OpLoad %74 
					                                       f32_4 %76 = OpLoad %58 
					                                       f32_4 %77 = OpVectorShuffle %76 %76 2 2 2 2 
					                                       f32_4 %78 = OpFMul %75 %77 
					                                       f32_4 %79 = OpLoad %56 
					                                       f32_4 %80 = OpFAdd %78 %79 
					                                                     OpStore %56 %80 
					                                       f32_4 %81 = OpLoad %56 
					                              Uniform f32_4* %83 = OpAccessChain %18 %61 %82 
					                                       f32_4 %84 = OpLoad %83 
					                                       f32_4 %85 = OpFAdd %81 %84 
					                                                     OpStore %56 %85 
					                                       f32_4 %87 = OpLoad %56 
					                                       f32_4 %88 = OpVectorShuffle %87 %87 1 1 1 1 
					                              Uniform f32_4* %89 = OpAccessChain %18 %62 %62 
					                                       f32_4 %90 = OpLoad %89 
					                                       f32_4 %91 = OpFMul %88 %90 
					                                                     OpStore %86 %91 
					                              Uniform f32_4* %92 = OpAccessChain %18 %62 %61 
					                                       f32_4 %93 = OpLoad %92 
					                                       f32_4 %94 = OpLoad %56 
					                                       f32_4 %95 = OpVectorShuffle %94 %94 0 0 0 0 
					                                       f32_4 %96 = OpFMul %93 %95 
					                                       f32_4 %97 = OpLoad %86 
					                                       f32_4 %98 = OpFAdd %96 %97 
					                                                     OpStore %86 %98 
					                              Uniform f32_4* %99 = OpAccessChain %18 %62 %20 
					                                      f32_4 %100 = OpLoad %99 
					                                      f32_4 %101 = OpLoad %56 
					                                      f32_4 %102 = OpVectorShuffle %101 %101 2 2 2 2 
					                                      f32_4 %103 = OpFMul %100 %102 
					                                      f32_4 %104 = OpLoad %86 
					                                      f32_4 %105 = OpFAdd %103 %104 
					                                                     OpStore %86 %105 
					                             Uniform f32_4* %110 = OpAccessChain %18 %62 %82 
					                                      f32_4 %111 = OpLoad %110 
					                                      f32_4 %112 = OpLoad %56 
					                                      f32_4 %113 = OpVectorShuffle %112 %112 3 3 3 3 
					                                      f32_4 %114 = OpFMul %111 %113 
					                                      f32_4 %115 = OpLoad %86 
					                                      f32_4 %116 = OpFAdd %114 %115 
					                              Output f32_4* %118 = OpAccessChain %109 %61 
					                                                     OpStore %118 %116 
					                                      f32_4 %121 = OpLoad %120 
					                                                     OpStore %119 %121 
					                                      f32_4 %124 = OpLoad %38 
					                                      f32_2 %125 = OpVectorShuffle %124 %124 0 1 
					                                                     OpStore vs_TEXCOORD0 %125 
					                                      f32_4 %127 = OpLoad %38 
					                                      f32_2 %128 = OpVectorShuffle %127 %127 2 3 
					                                                     OpStore vs_TEXCOORD1 %128 
					                                Output f32* %130 = OpAccessChain %109 %61 %21 
					                                        f32 %131 = OpLoad %130 
					                                        f32 %132 = OpFNegate %131 
					                                Output f32* %133 = OpAccessChain %109 %61 %21 
					                                                     OpStore %133 %132 
					                                                     OpReturn
					                                                     OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 161
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %12 %147 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate vs_TEXCOORD0 Location 12 
					                                                      OpMemberDecorate %15 0 Offset 15 
					                                                      OpMemberDecorate %15 1 Offset 15 
					                                                      OpMemberDecorate %15 2 Offset 15 
					                                                      OpMemberDecorate %15 3 Offset 15 
					                                                      OpMemberDecorate %15 4 Offset 15 
					                                                      OpMemberDecorate %15 5 RelaxedPrecision 
					                                                      OpMemberDecorate %15 5 Offset 15 
					                                                      OpDecorate %15 Block 
					                                                      OpDecorate %17 DescriptorSet 17 
					                                                      OpDecorate %17 Binding 17 
					                                                      OpDecorate %22 RelaxedPrecision 
					                                                      OpDecorate %23 RelaxedPrecision 
					                                                      OpDecorate %26 RelaxedPrecision 
					                                                      OpDecorate %27 RelaxedPrecision 
					                                                      OpDecorate %31 RelaxedPrecision 
					                                                      OpDecorate %34 RelaxedPrecision 
					                                                      OpDecorate %34 DescriptorSet 34 
					                                                      OpDecorate %34 Binding 34 
					                                                      OpDecorate %35 RelaxedPrecision 
					                                                      OpDecorate %38 RelaxedPrecision 
					                                                      OpDecorate %38 DescriptorSet 38 
					                                                      OpDecorate %38 Binding 38 
					                                                      OpDecorate %39 RelaxedPrecision 
					                                                      OpDecorate %44 RelaxedPrecision 
					                                                      OpDecorate %46 RelaxedPrecision 
					                                                      OpDecorate %51 RelaxedPrecision 
					                                                      OpDecorate %52 RelaxedPrecision 
					                                                      OpDecorate %53 RelaxedPrecision 
					                                                      OpDecorate %61 RelaxedPrecision 
					                                                      OpDecorate %62 RelaxedPrecision 
					                                                      OpDecorate %63 RelaxedPrecision 
					                                                      OpDecorate %64 RelaxedPrecision 
					                                                      OpDecorate %65 RelaxedPrecision 
					                                                      OpDecorate %66 RelaxedPrecision 
					                                                      OpDecorate %69 RelaxedPrecision 
					                                                      OpDecorate %77 RelaxedPrecision 
					                                                      OpDecorate %78 RelaxedPrecision 
					                                                      OpDecorate %79 RelaxedPrecision 
					                                                      OpDecorate %80 RelaxedPrecision 
					                                                      OpDecorate %81 RelaxedPrecision 
					                                                      OpDecorate %82 RelaxedPrecision 
					                                                      OpDecorate %86 RelaxedPrecision 
					                                                      OpDecorate %94 RelaxedPrecision 
					                                                      OpDecorate %95 RelaxedPrecision 
					                                                      OpDecorate %96 RelaxedPrecision 
					                                                      OpDecorate %97 RelaxedPrecision 
					                                                      OpDecorate %98 RelaxedPrecision 
					                                                      OpDecorate %99 RelaxedPrecision 
					                                                      OpDecorate %112 RelaxedPrecision 
					                                                      OpDecorate %113 RelaxedPrecision 
					                                                      OpDecorate %113 DescriptorSet 113 
					                                                      OpDecorate %113 Binding 113 
					                                                      OpDecorate %114 RelaxedPrecision 
					                                                      OpDecorate %115 RelaxedPrecision 
					                                                      OpDecorate %115 DescriptorSet 115 
					                                                      OpDecorate %115 Binding 115 
					                                                      OpDecorate %116 RelaxedPrecision 
					                                                      OpDecorate %121 RelaxedPrecision 
					                                                      OpDecorate %136 RelaxedPrecision 
					                                                      OpDecorate %147 Location 147 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 3 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_3* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 2 
					                                              %11 = OpTypePointer Input %10 
					                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                              %14 = OpTypeVector %6 4 
					                                              %15 = OpTypeStruct %6 %6 %6 %6 %6 %14 
					                                              %16 = OpTypePointer Uniform %15 
					Uniform struct {f32; f32; f32; f32; f32; f32_4;}* %17 = OpVariable Uniform 
					                                              %18 = OpTypeInt 32 1 
					                                          i32 %19 = OpConstant 5 
					                                              %20 = OpTypePointer Uniform %14 
					                               Private f32_3* %31 = OpVariable Private 
					                                              %32 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %33 = OpTypePointer UniformConstant %32 
					         UniformConstant read_only Texture2D* %34 = OpVariable UniformConstant 
					                                              %36 = OpTypeSampler 
					                                              %37 = OpTypePointer UniformConstant %36 
					                     UniformConstant sampler* %38 = OpVariable UniformConstant 
					                                              %40 = OpTypeSampledImage %32 
					                               Private f32_3* %45 = OpVariable Private 
					                                          i32 %47 = OpConstant 2 
					                                              %48 = OpTypePointer Uniform %6 
					                                          i32 %54 = OpConstant 3 
					                                          i32 %70 = OpConstant 4 
					                               Private f32_3* %85 = OpVariable Private 
					                                          i32 %87 = OpConstant 1 
					                                         f32 %104 = OpConstant 3,674022E-40 
					                                       f32_2 %105 = OpConstantComposite %104 %104 
					                              Private f32_3* %112 = OpVariable Private 
					        UniformConstant read_only Texture2D* %113 = OpVariable UniformConstant 
					                    UniformConstant sampler* %115 = OpVariable UniformConstant 
					                                         i32 %123 = OpConstant 0 
					                                             %138 = OpTypePointer Private %6 
					                                Private f32* %139 = OpVariable Private 
					                                             %140 = OpTypeInt 32 0 
					                                         u32 %141 = OpConstant 0 
					                                         f32 %144 = OpConstant 3,674022E-40 
					                                             %146 = OpTypePointer Output %14 
					                               Output f32_4* %147 = OpVariable Output 
					                                             %152 = OpTypePointer Output %6 
					                                         u32 %158 = OpConstant 3 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_2 %13 = OpLoad vs_TEXCOORD0 
					                               Uniform f32_4* %21 = OpAccessChain %17 %19 
					                                        f32_4 %22 = OpLoad %21 
					                                        f32_2 %23 = OpVectorShuffle %22 %22 0 1 
					                                        f32_2 %24 = OpFMul %13 %23 
					                               Uniform f32_4* %25 = OpAccessChain %17 %19 
					                                        f32_4 %26 = OpLoad %25 
					                                        f32_2 %27 = OpVectorShuffle %26 %26 2 3 
					                                        f32_2 %28 = OpFAdd %24 %27 
					                                        f32_3 %29 = OpLoad %9 
					                                        f32_3 %30 = OpVectorShuffle %29 %28 3 4 2 
					                                                      OpStore %9 %30 
					                          read_only Texture2D %35 = OpLoad %34 
					                                      sampler %39 = OpLoad %38 
					                   read_only Texture2DSampled %41 = OpSampledImage %35 %39 
					                                        f32_2 %42 = OpLoad vs_TEXCOORD0 
					                                        f32_4 %43 = OpImageSampleImplicitLod %41 %42 
					                                        f32_3 %44 = OpVectorShuffle %43 %43 0 1 2 
					                                                      OpStore %31 %44 
					                                        f32_3 %46 = OpLoad %31 
					                                 Uniform f32* %49 = OpAccessChain %17 %47 
					                                          f32 %50 = OpLoad %49 
					                                        f32_3 %51 = OpCompositeConstruct %50 %50 %50 
					                                        f32_3 %52 = OpFMul %46 %51 
					                                                      OpStore %45 %52 
					                                        f32_3 %53 = OpLoad %31 
					                                 Uniform f32* %55 = OpAccessChain %17 %54 
					                                          f32 %56 = OpLoad %55 
					                                 Uniform f32* %57 = OpAccessChain %17 %54 
					                                          f32 %58 = OpLoad %57 
					                                 Uniform f32* %59 = OpAccessChain %17 %54 
					                                          f32 %60 = OpLoad %59 
					                                        f32_3 %61 = OpCompositeConstruct %56 %58 %60 
					                                          f32 %62 = OpCompositeExtract %61 0 
					                                          f32 %63 = OpCompositeExtract %61 1 
					                                          f32 %64 = OpCompositeExtract %61 2 
					                                        f32_3 %65 = OpCompositeConstruct %62 %63 %64 
					                                        f32_3 %66 = OpFMul %53 %65 
					                                        f32_3 %67 = OpLoad %45 
					                                        f32_3 %68 = OpFAdd %66 %67 
					                                                      OpStore %45 %68 
					                                        f32_3 %69 = OpLoad %31 
					                                 Uniform f32* %71 = OpAccessChain %17 %70 
					                                          f32 %72 = OpLoad %71 
					                                 Uniform f32* %73 = OpAccessChain %17 %70 
					                                          f32 %74 = OpLoad %73 
					                                 Uniform f32* %75 = OpAccessChain %17 %70 
					                                          f32 %76 = OpLoad %75 
					                                        f32_3 %77 = OpCompositeConstruct %72 %74 %76 
					                                          f32 %78 = OpCompositeExtract %77 0 
					                                          f32 %79 = OpCompositeExtract %77 1 
					                                          f32 %80 = OpCompositeExtract %77 2 
					                                        f32_3 %81 = OpCompositeConstruct %78 %79 %80 
					                                        f32_3 %82 = OpFMul %69 %81 
					                                        f32_3 %83 = OpLoad %45 
					                                        f32_3 %84 = OpFAdd %82 %83 
					                                                      OpStore %45 %84 
					                                        f32_3 %86 = OpLoad %31 
					                                 Uniform f32* %88 = OpAccessChain %17 %87 
					                                          f32 %89 = OpLoad %88 
					                                 Uniform f32* %90 = OpAccessChain %17 %87 
					                                          f32 %91 = OpLoad %90 
					                                 Uniform f32* %92 = OpAccessChain %17 %87 
					                                          f32 %93 = OpLoad %92 
					                                        f32_3 %94 = OpCompositeConstruct %89 %91 %93 
					                                          f32 %95 = OpCompositeExtract %94 0 
					                                          f32 %96 = OpCompositeExtract %94 1 
					                                          f32 %97 = OpCompositeExtract %94 2 
					                                        f32_3 %98 = OpCompositeConstruct %95 %96 %97 
					                                        f32_3 %99 = OpFMul %86 %98 
					                                       f32_3 %100 = OpLoad %45 
					                                       f32_3 %101 = OpFAdd %99 %100 
					                                                      OpStore %85 %101 
					                                       f32_3 %102 = OpLoad %85 
					                                       f32_2 %103 = OpVectorShuffle %102 %102 0 0 
					                                       f32_2 %106 = OpFMul %103 %105 
					                                       f32_3 %107 = OpLoad %9 
					                                       f32_2 %108 = OpVectorShuffle %107 %107 0 1 
					                                       f32_2 %109 = OpFAdd %106 %108 
					                                       f32_3 %110 = OpLoad %9 
					                                       f32_3 %111 = OpVectorShuffle %110 %109 3 4 2 
					                                                      OpStore %9 %111 
					                         read_only Texture2D %114 = OpLoad %113 
					                                     sampler %116 = OpLoad %115 
					                  read_only Texture2DSampled %117 = OpSampledImage %114 %116 
					                                       f32_3 %118 = OpLoad %9 
					                                       f32_2 %119 = OpVectorShuffle %118 %118 0 1 
					                                       f32_4 %120 = OpImageSampleImplicitLod %117 %119 
					                                       f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
					                                                      OpStore %112 %121 
					                                       f32_3 %122 = OpLoad %85 
					                                Uniform f32* %124 = OpAccessChain %17 %123 
					                                         f32 %125 = OpLoad %124 
					                                Uniform f32* %126 = OpAccessChain %17 %123 
					                                         f32 %127 = OpLoad %126 
					                                Uniform f32* %128 = OpAccessChain %17 %123 
					                                         f32 %129 = OpLoad %128 
					                                       f32_3 %130 = OpCompositeConstruct %125 %127 %129 
					                                         f32 %131 = OpCompositeExtract %130 0 
					                                         f32 %132 = OpCompositeExtract %130 1 
					                                         f32 %133 = OpCompositeExtract %130 2 
					                                       f32_3 %134 = OpCompositeConstruct %131 %132 %133 
					                                       f32_3 %135 = OpFMul %122 %134 
					                                       f32_3 %136 = OpLoad %112 
					                                       f32_3 %137 = OpFAdd %135 %136 
					                                                      OpStore %9 %137 
					                                Private f32* %142 = OpAccessChain %85 %141 
					                                         f32 %143 = OpLoad %142 
					                                         f32 %145 = OpFAdd %143 %144 
					                                                      OpStore %139 %145 
					                                         f32 %148 = OpLoad %139 
					                                Private f32* %149 = OpAccessChain %9 %141 
					                                         f32 %150 = OpLoad %149 
					                                         f32 %151 = OpFMul %148 %150 
					                                 Output f32* %153 = OpAccessChain %147 %141 
					                                                      OpStore %153 %151 
					                                       f32_3 %154 = OpLoad %9 
					                                       f32_2 %155 = OpVectorShuffle %154 %154 1 2 
					                                       f32_4 %156 = OpLoad %147 
					                                       f32_4 %157 = OpVectorShuffle %156 %155 0 4 5 3 
					                                                      OpStore %147 %157 
					                                 Output f32* %159 = OpAccessChain %147 %158 
					                                                      OpStore %159 %144 
					                                                      OpReturn
					                                                      OpFunctionEnd
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"!!ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						float _Value;
						float _Value2;
						float _Value3;
						float _Value4;
						float _Value5;
						vec4 unused_0_6[2];
						vec4 _MainTex_ST;
					};
					uniform  sampler2D _MainTex2;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat10_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1 = texture(_MainTex2, vs_TEXCOORD0.xy);
					    u_xlat2.xyz = u_xlat10_1.xyz * vec3(_Value3);
					    u_xlat2.xyz = u_xlat10_1.xyz * vec3(vec3(_Value4, _Value4, _Value4)) + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat10_1.xyz * vec3(vec3(_Value5, _Value5, _Value5)) + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * vec3(vec3(_Value2, _Value2, _Value2)) + u_xlat2.xyz;
					    u_xlat0.xy = u_xlat1.xx * vec2(0.001953125, 0.001953125) + u_xlat0.xy;
					    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_Value, _Value, _Value)) + u_xlat10_0.xyz;
					    u_xlat9 = u_xlat1.x + 1.0;
					    SV_Target0.x = u_xlat9 * u_xlat0.x;
					    SV_Target0.yz = u_xlat0.yz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "glcore " {
					"!!!!GL3x"
				}
				SubProgram "vulkan " {
					"!!vulkan"
				}
			}
		}
	}
}