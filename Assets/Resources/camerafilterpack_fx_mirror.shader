Shader "CameraFilterPack/FX_Mirror" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_TimeX ("Time", Range(0, 1)) = 1
		_Distortion ("_Distortion", Range(0, 1)) = 0.3
		_ScreenResolution ("_ScreenResolution", Vector) = (0,0,0,0)
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 33181
			Program "vp" {
				SubProgram "d3d11 " {
					"!!vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0;
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
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0;
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
					uniform 	vec4 _MainTex_ST;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat10_0;
					vec2 u_xlat1;
					bvec2 u_xlatb4;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.5, 0.5), u_xlat0.xyxy).xy;
					    u_xlat1.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
					    {
					        vec2 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat1.x : u_xlat0.x;
					        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat1.y : u_xlat0.y;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
					    SV_Target0.xyz = u_xlat10_0.xyz;
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
					; Bound: 97
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Vertex %4 "main" %9 %11 %17 %78 %88 %89 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpDecorate vs_TEXCOORD0 Location 9 
					                                              OpDecorate %11 Location 11 
					                                              OpDecorate %17 Location 17 
					                                              OpDecorate %22 ArrayStride 22 
					                                              OpDecorate %23 ArrayStride 23 
					                                              OpMemberDecorate %24 0 Offset 24 
					                                              OpMemberDecorate %24 1 Offset 24 
					                                              OpDecorate %24 Block 
					                                              OpDecorate %26 DescriptorSet 26 
					                                              OpDecorate %26 Binding 26 
					                                              OpMemberDecorate %76 0 BuiltIn 76 
					                                              OpMemberDecorate %76 1 BuiltIn 76 
					                                              OpMemberDecorate %76 2 BuiltIn 76 
					                                              OpDecorate %76 Block 
					                                              OpDecorate %88 Location 88 
					                                              OpDecorate %89 Location 89 
					                                       %2 = OpTypeVoid 
					                                       %3 = OpTypeFunction %2 
					                                       %6 = OpTypeFloat 32 
					                                       %7 = OpTypeVector %6 2 
					                                       %8 = OpTypePointer Output %7 
					               Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                      %10 = OpTypePointer Input %7 
					                         Input f32_2* %11 = OpVariable Input 
					                                      %13 = OpTypeVector %6 4 
					                                      %14 = OpTypePointer Private %13 
					                       Private f32_4* %15 = OpVariable Private 
					                                      %16 = OpTypePointer Input %13 
					                         Input f32_4* %17 = OpVariable Input 
					                                      %20 = OpTypeInt 32 0 
					                                  u32 %21 = OpConstant 4 
					                                      %22 = OpTypeArray %13 %21 
					                                      %23 = OpTypeArray %13 %21 
					                                      %24 = OpTypeStruct %22 %23 
					                                      %25 = OpTypePointer Uniform %24 
					Uniform struct {f32_4[4]; f32_4[4];}* %26 = OpVariable Uniform 
					                                      %27 = OpTypeInt 32 1 
					                                  i32 %28 = OpConstant 0 
					                                  i32 %29 = OpConstant 1 
					                                      %30 = OpTypePointer Uniform %13 
					                                  i32 %41 = OpConstant 2 
					                                  i32 %50 = OpConstant 3 
					                       Private f32_4* %54 = OpVariable Private 
					                                  u32 %74 = OpConstant 1 
					                                      %75 = OpTypeArray %6 %74 
					                                      %76 = OpTypeStruct %13 %6 %75 
					                                      %77 = OpTypePointer Output %76 
					 Output struct {f32_4; f32; f32[1];}* %78 = OpVariable Output 
					                                      %86 = OpTypePointer Output %13 
					                        Output f32_4* %88 = OpVariable Output 
					                         Input f32_4* %89 = OpVariable Input 
					                                      %91 = OpTypePointer Output %6 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                                f32_2 %12 = OpLoad %11 
					                                              OpStore vs_TEXCOORD0 %12 
					                                f32_4 %18 = OpLoad %17 
					                                f32_4 %19 = OpVectorShuffle %18 %18 1 1 1 1 
					                       Uniform f32_4* %31 = OpAccessChain %26 %28 %29 
					                                f32_4 %32 = OpLoad %31 
					                                f32_4 %33 = OpFMul %19 %32 
					                                              OpStore %15 %33 
					                       Uniform f32_4* %34 = OpAccessChain %26 %28 %28 
					                                f32_4 %35 = OpLoad %34 
					                                f32_4 %36 = OpLoad %17 
					                                f32_4 %37 = OpVectorShuffle %36 %36 0 0 0 0 
					                                f32_4 %38 = OpFMul %35 %37 
					                                f32_4 %39 = OpLoad %15 
					                                f32_4 %40 = OpFAdd %38 %39 
					                                              OpStore %15 %40 
					                       Uniform f32_4* %42 = OpAccessChain %26 %28 %41 
					                                f32_4 %43 = OpLoad %42 
					                                f32_4 %44 = OpLoad %17 
					                                f32_4 %45 = OpVectorShuffle %44 %44 2 2 2 2 
					                                f32_4 %46 = OpFMul %43 %45 
					                                f32_4 %47 = OpLoad %15 
					                                f32_4 %48 = OpFAdd %46 %47 
					                                              OpStore %15 %48 
					                                f32_4 %49 = OpLoad %15 
					                       Uniform f32_4* %51 = OpAccessChain %26 %28 %50 
					                                f32_4 %52 = OpLoad %51 
					                                f32_4 %53 = OpFAdd %49 %52 
					                                              OpStore %15 %53 
					                                f32_4 %55 = OpLoad %15 
					                                f32_4 %56 = OpVectorShuffle %55 %55 1 1 1 1 
					                       Uniform f32_4* %57 = OpAccessChain %26 %29 %29 
					                                f32_4 %58 = OpLoad %57 
					                                f32_4 %59 = OpFMul %56 %58 
					                                              OpStore %54 %59 
					                       Uniform f32_4* %60 = OpAccessChain %26 %29 %28 
					                                f32_4 %61 = OpLoad %60 
					                                f32_4 %62 = OpLoad %15 
					                                f32_4 %63 = OpVectorShuffle %62 %62 0 0 0 0 
					                                f32_4 %64 = OpFMul %61 %63 
					                                f32_4 %65 = OpLoad %54 
					                                f32_4 %66 = OpFAdd %64 %65 
					                                              OpStore %54 %66 
					                       Uniform f32_4* %67 = OpAccessChain %26 %29 %41 
					                                f32_4 %68 = OpLoad %67 
					                                f32_4 %69 = OpLoad %15 
					                                f32_4 %70 = OpVectorShuffle %69 %69 2 2 2 2 
					                                f32_4 %71 = OpFMul %68 %70 
					                                f32_4 %72 = OpLoad %54 
					                                f32_4 %73 = OpFAdd %71 %72 
					                                              OpStore %54 %73 
					                       Uniform f32_4* %79 = OpAccessChain %26 %29 %50 
					                                f32_4 %80 = OpLoad %79 
					                                f32_4 %81 = OpLoad %15 
					                                f32_4 %82 = OpVectorShuffle %81 %81 3 3 3 3 
					                                f32_4 %83 = OpFMul %80 %82 
					                                f32_4 %84 = OpLoad %54 
					                                f32_4 %85 = OpFAdd %83 %84 
					                        Output f32_4* %87 = OpAccessChain %78 %28 
					                                              OpStore %87 %85 
					                                f32_4 %90 = OpLoad %89 
					                                              OpStore %88 %90 
					                          Output f32* %92 = OpAccessChain %78 %28 %74 
					                                  f32 %93 = OpLoad %92 
					                                  f32 %94 = OpFNegate %93 
					                          Output f32* %95 = OpAccessChain %78 %28 %74 
					                                              OpStore %95 %94 
					                                              OpReturn
					                                              OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 104
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %11 %96 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpDecorate vs_TEXCOORD0 Location 11 
					                                             OpMemberDecorate %14 0 RelaxedPrecision 
					                                             OpMemberDecorate %14 0 Offset 14 
					                                             OpDecorate %14 Block 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate %21 RelaxedPrecision 
					                                             OpDecorate %22 RelaxedPrecision 
					                                             OpDecorate %25 RelaxedPrecision 
					                                             OpDecorate %26 RelaxedPrecision 
					                                             OpDecorate %81 RelaxedPrecision 
					                                             OpDecorate %84 RelaxedPrecision 
					                                             OpDecorate %84 DescriptorSet 84 
					                                             OpDecorate %84 Binding 84 
					                                             OpDecorate %85 RelaxedPrecision 
					                                             OpDecorate %88 RelaxedPrecision 
					                                             OpDecorate %88 DescriptorSet 88 
					                                             OpDecorate %88 Binding 88 
					                                             OpDecorate %89 RelaxedPrecision 
					                                             OpDecorate %94 RelaxedPrecision 
					                                             OpDecorate %96 Location 96 
					                                             OpDecorate %97 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 2 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_2* %9 = OpVariable Private 
					                                     %10 = OpTypePointer Input %7 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %13 = OpTypeVector %6 4 
					                                     %14 = OpTypeStruct %13 
					                                     %15 = OpTypePointer Uniform %14 
					            Uniform struct {f32_4;}* %16 = OpVariable Uniform 
					                                     %17 = OpTypeInt 32 1 
					                                 i32 %18 = OpConstant 0 
					                                     %19 = OpTypePointer Uniform %13 
					                                     %28 = OpTypeBool 
					                                     %29 = OpTypeVector %28 2 
					                                     %30 = OpTypePointer Private %29 
					                     Private bool_2* %31 = OpVariable Private 
					                                 f32 %32 = OpConstant 3,674022E-40 
					                               f32_4 %33 = OpConstantComposite %32 %32 %32 %32 
					                                     %36 = OpTypeVector %28 4 
					                      Private f32_2* %39 = OpVariable Private 
					                                 f32 %42 = OpConstant 3,674022E-40 
					                               f32_2 %43 = OpConstantComposite %42 %42 
					                                     %45 = OpTypePointer Function %7 
					                                     %48 = OpTypeInt 32 0 
					                                 u32 %49 = OpConstant 0 
					                                     %50 = OpTypePointer Private %28 
					                                     %53 = OpTypePointer Function %6 
					                                     %57 = OpTypePointer Private %6 
					                                 u32 %65 = OpConstant 1 
					                                     %79 = OpTypeVector %6 3 
					                                     %80 = OpTypePointer Private %79 
					                      Private f32_3* %81 = OpVariable Private 
					                                     %82 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %83 = OpTypePointer UniformConstant %82 
					UniformConstant read_only Texture2D* %84 = OpVariable UniformConstant 
					                                     %86 = OpTypeSampler 
					                                     %87 = OpTypePointer UniformConstant %86 
					            UniformConstant sampler* %88 = OpVariable UniformConstant 
					                                     %90 = OpTypeSampledImage %82 
					                                     %95 = OpTypePointer Output %13 
					                       Output f32_4* %96 = OpVariable Output 
					                                u32 %100 = OpConstant 3 
					                                    %101 = OpTypePointer Output %6 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                     Function f32_2* %46 = OpVariable Function 
					                       Function f32* %54 = OpVariable Function 
					                       Function f32* %68 = OpVariable Function 
					                               f32_2 %12 = OpLoad vs_TEXCOORD0 
					                      Uniform f32_4* %20 = OpAccessChain %16 %18 
					                               f32_4 %21 = OpLoad %20 
					                               f32_2 %22 = OpVectorShuffle %21 %21 0 1 
					                               f32_2 %23 = OpFMul %12 %22 
					                      Uniform f32_4* %24 = OpAccessChain %16 %18 
					                               f32_4 %25 = OpLoad %24 
					                               f32_2 %26 = OpVectorShuffle %25 %25 2 3 
					                               f32_2 %27 = OpFAdd %23 %26 
					                                             OpStore %9 %27 
					                               f32_2 %34 = OpLoad %9 
					                               f32_4 %35 = OpVectorShuffle %34 %34 0 1 0 1 
					                              bool_4 %37 = OpFOrdLessThan %33 %35 
					                              bool_2 %38 = OpVectorShuffle %37 %37 0 1 
					                                             OpStore %31 %38 
					                               f32_2 %40 = OpLoad %9 
					                               f32_2 %41 = OpFNegate %40 
					                               f32_2 %44 = OpFAdd %41 %43 
					                                             OpStore %39 %44 
					                               f32_2 %47 = OpLoad %9 
					                                             OpStore %46 %47 
					                       Private bool* %51 = OpAccessChain %31 %49 
					                                bool %52 = OpLoad %51 
					                                             OpSelectionMerge %56 None 
					                                             OpBranchConditional %52 %55 %60 
					                                     %55 = OpLabel 
					                        Private f32* %58 = OpAccessChain %39 %49 
					                                 f32 %59 = OpLoad %58 
					                                             OpStore %54 %59 
					                                             OpBranch %56 
					                                     %60 = OpLabel 
					                        Private f32* %61 = OpAccessChain %9 %49 
					                                 f32 %62 = OpLoad %61 
					                                             OpStore %54 %62 
					                                             OpBranch %56 
					                                     %56 = OpLabel 
					                                 f32 %63 = OpLoad %54 
					                       Function f32* %64 = OpAccessChain %46 %49 
					                                             OpStore %64 %63 
					                       Private bool* %66 = OpAccessChain %31 %65 
					                                bool %67 = OpLoad %66 
					                                             OpSelectionMerge %70 None 
					                                             OpBranchConditional %67 %69 %73 
					                                     %69 = OpLabel 
					                        Private f32* %71 = OpAccessChain %39 %65 
					                                 f32 %72 = OpLoad %71 
					                                             OpStore %68 %72 
					                                             OpBranch %70 
					                                     %73 = OpLabel 
					                        Private f32* %74 = OpAccessChain %9 %65 
					                                 f32 %75 = OpLoad %74 
					                                             OpStore %68 %75 
					                                             OpBranch %70 
					                                     %70 = OpLabel 
					                                 f32 %76 = OpLoad %68 
					                       Function f32* %77 = OpAccessChain %46 %65 
					                                             OpStore %77 %76 
					                               f32_2 %78 = OpLoad %46 
					                                             OpStore %9 %78 
					                 read_only Texture2D %85 = OpLoad %84 
					                             sampler %89 = OpLoad %88 
					          read_only Texture2DSampled %91 = OpSampledImage %85 %89 
					                               f32_2 %92 = OpLoad %9 
					                               f32_4 %93 = OpImageSampleImplicitLod %91 %92 
					                               f32_3 %94 = OpVectorShuffle %93 %93 0 1 2 
					                                             OpStore %81 %94 
					                               f32_3 %97 = OpLoad %81 
					                               f32_4 %98 = OpLoad %96 
					                               f32_4 %99 = OpVectorShuffle %98 %97 4 5 6 3 
					                                             OpStore %96 %99 
					                        Output f32* %102 = OpAccessChain %96 %100 
					                                             OpStore %102 %42 
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
						vec4 unused_0_0[4];
						vec4 _MainTex_ST;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat10_0;
					vec2 u_xlat1;
					bvec2 u_xlatb4;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.5, 0.5), u_xlat0.xyxy).xy;
					    u_xlat1.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
					    {
					        vec2 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat1.x : u_xlat0.x;
					        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat1.y : u_xlat0.y;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
					    SV_Target0.xyz = u_xlat10_0.xyz;
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