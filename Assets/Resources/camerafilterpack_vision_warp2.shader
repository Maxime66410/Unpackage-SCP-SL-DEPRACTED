Shader "CameraFilterPack/Vision_Warp2" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_TimeX ("Time", Range(0, 1)) = 1
		_ScreenResolution ("_ScreenResolution", Vector) = (0,0,0,0)
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 10242
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
					uniform 	float _TimeX;
					uniform 	float _Value;
					uniform 	float _Value2;
					uniform 	float _Value3;
					uniform 	vec4 _MainTex_ST;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat10_0;
					vec2 u_xlat1;
					vec2 u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4.xy = u_xlat0.xy + vec2(-0.5, -0.5);
					    u_xlat4.x = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = (-_TimeX) * 0.333333343 + u_xlat4.x;
					    u_xlat4.x = u_xlat4.x * 5.0;
					    u_xlat4.x = sin(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * u_xlat4.x;
					    u_xlat6 = u_xlat4.x * 99.9999924;
					    u_xlatb4 = 0.00100000005>=u_xlat4.x;
					    u_xlat1.x = sin(u_xlat6);
					    u_xlat6 = u_xlat1.x / u_xlat6;
					    u_xlat4.x = (u_xlatb4) ? 1.0 : abs(u_xlat6);
					    u_xlat1.xy = (-u_xlat0.xy) + vec2(0.5, 0.5);
					    u_xlat6 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat6 = sqrt(u_xlat6);
					    u_xlat6 = u_xlat6 + (-_Value);
					    u_xlat1.x = _Value + -0.0500000007;
					    u_xlat1.x = u_xlat1.x + (-_Value2);
					    u_xlat1.x = u_xlat1.x + (-_Value);
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat6 = u_xlat6 * u_xlat1.x;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.x = u_xlat6 * -2.0 + 3.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = (-u_xlat1.x) * u_xlat6 + 1.0;
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat0.xy = (-u_xlat4.xx) * vec2(vec2(_Value3, _Value3)) + u_xlat0.xy;
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
					; Bound: 210
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Fragment %4 "main" %11 %202 
					                                                     OpExecutionMode %4 OriginUpperLeft 
					                                                     OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                     OpDecorate vs_TEXCOORD0 Location 11 
					                                                     OpMemberDecorate %14 0 Offset 14 
					                                                     OpMemberDecorate %14 1 Offset 14 
					                                                     OpMemberDecorate %14 2 Offset 14 
					                                                     OpMemberDecorate %14 3 Offset 14 
					                                                     OpMemberDecorate %14 4 RelaxedPrecision 
					                                                     OpMemberDecorate %14 4 Offset 14 
					                                                     OpDecorate %14 Block 
					                                                     OpDecorate %16 DescriptorSet 16 
					                                                     OpDecorate %16 Binding 16 
					                                                     OpDecorate %21 RelaxedPrecision 
					                                                     OpDecorate %22 RelaxedPrecision 
					                                                     OpDecorate %25 RelaxedPrecision 
					                                                     OpDecorate %26 RelaxedPrecision 
					                                                     OpDecorate %187 RelaxedPrecision 
					                                                     OpDecorate %190 RelaxedPrecision 
					                                                     OpDecorate %190 DescriptorSet 190 
					                                                     OpDecorate %190 Binding 190 
					                                                     OpDecorate %191 RelaxedPrecision 
					                                                     OpDecorate %194 RelaxedPrecision 
					                                                     OpDecorate %194 DescriptorSet 194 
					                                                     OpDecorate %194 Binding 194 
					                                                     OpDecorate %195 RelaxedPrecision 
					                                                     OpDecorate %200 RelaxedPrecision 
					                                                     OpDecorate %202 Location 202 
					                                                     OpDecorate %203 RelaxedPrecision 
					                                              %2 = OpTypeVoid 
					                                              %3 = OpTypeFunction %2 
					                                              %6 = OpTypeFloat 32 
					                                              %7 = OpTypeVector %6 2 
					                                              %8 = OpTypePointer Private %7 
					                               Private f32_2* %9 = OpVariable Private 
					                                             %10 = OpTypePointer Input %7 
					                       Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                             %13 = OpTypeVector %6 4 
					                                             %14 = OpTypeStruct %6 %6 %6 %6 %13 
					                                             %15 = OpTypePointer Uniform %14 
					Uniform struct {f32; f32; f32; f32; f32_4;}* %16 = OpVariable Uniform 
					                                             %17 = OpTypeInt 32 1 
					                                         i32 %18 = OpConstant 4 
					                                             %19 = OpTypePointer Uniform %13 
					                              Private f32_2* %28 = OpVariable Private 
					                                         f32 %30 = OpConstant 3,674022E-40 
					                                       f32_2 %31 = OpConstantComposite %30 %30 
					                                             %38 = OpTypeInt 32 0 
					                                         u32 %39 = OpConstant 0 
					                                             %40 = OpTypePointer Private %6 
					                                         i32 %46 = OpConstant 0 
					                                             %47 = OpTypePointer Uniform %6 
					                                         f32 %51 = OpConstant 3,674022E-40 
					                                         f32 %59 = OpConstant 3,674022E-40 
					                                Private f32* %72 = OpVariable Private 
					                                         f32 %75 = OpConstant 3,674022E-40 
					                                             %77 = OpTypeBool 
					                                             %78 = OpTypePointer Private %77 
					                               Private bool* %79 = OpVariable Private 
					                                         f32 %80 = OpConstant 3,674022E-40 
					                              Private f32_2* %84 = OpVariable Private 
					                                             %93 = OpTypePointer Function %6 
					                                         f32 %97 = OpConstant 3,674022E-40 
					                                        f32 %105 = OpConstant 3,674022E-40 
					                                      f32_2 %106 = OpConstantComposite %105 %105 
					                                        i32 %114 = OpConstant 1 
					                                        f32 %121 = OpConstant 3,674022E-40 
					                                        i32 %126 = OpConstant 2 
					                                        f32 %148 = OpConstant 3,674022E-40 
					                                        f32 %151 = OpConstant 3,674022E-40 
					                                        f32 %153 = OpConstant 3,674022E-40 
					                                        i32 %173 = OpConstant 3 
					                                            %185 = OpTypeVector %6 3 
					                                            %186 = OpTypePointer Private %185 
					                             Private f32_3* %187 = OpVariable Private 
					                                            %188 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                            %189 = OpTypePointer UniformConstant %188 
					       UniformConstant read_only Texture2D* %190 = OpVariable UniformConstant 
					                                            %192 = OpTypeSampler 
					                                            %193 = OpTypePointer UniformConstant %192 
					                   UniformConstant sampler* %194 = OpVariable UniformConstant 
					                                            %196 = OpTypeSampledImage %188 
					                                            %201 = OpTypePointer Output %13 
					                              Output f32_4* %202 = OpVariable Output 
					                                        u32 %206 = OpConstant 3 
					                                            %207 = OpTypePointer Output %6 
					                                         void %4 = OpFunction None %3 
					                                              %5 = OpLabel 
					                               Function f32* %94 = OpVariable Function 
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
					                                       f32_2 %29 = OpLoad %9 
					                                       f32_2 %32 = OpFAdd %29 %31 
					                                                     OpStore %28 %32 
					                                       f32_2 %33 = OpLoad %28 
					                                       f32_2 %34 = OpExtInst %1 4 %33 
					                                       f32_2 %35 = OpLoad %28 
					                                       f32_2 %36 = OpExtInst %1 4 %35 
					                                         f32 %37 = OpDot %34 %36 
					                                Private f32* %41 = OpAccessChain %28 %39 
					                                                     OpStore %41 %37 
					                                Private f32* %42 = OpAccessChain %28 %39 
					                                         f32 %43 = OpLoad %42 
					                                         f32 %44 = OpExtInst %1 31 %43 
					                                Private f32* %45 = OpAccessChain %28 %39 
					                                                     OpStore %45 %44 
					                                Uniform f32* %48 = OpAccessChain %16 %46 
					                                         f32 %49 = OpLoad %48 
					                                         f32 %50 = OpFNegate %49 
					                                         f32 %52 = OpFMul %50 %51 
					                                Private f32* %53 = OpAccessChain %28 %39 
					                                         f32 %54 = OpLoad %53 
					                                         f32 %55 = OpFAdd %52 %54 
					                                Private f32* %56 = OpAccessChain %28 %39 
					                                                     OpStore %56 %55 
					                                Private f32* %57 = OpAccessChain %28 %39 
					                                         f32 %58 = OpLoad %57 
					                                         f32 %60 = OpFMul %58 %59 
					                                Private f32* %61 = OpAccessChain %28 %39 
					                                                     OpStore %61 %60 
					                                Private f32* %62 = OpAccessChain %28 %39 
					                                         f32 %63 = OpLoad %62 
					                                         f32 %64 = OpExtInst %1 13 %63 
					                                Private f32* %65 = OpAccessChain %28 %39 
					                                                     OpStore %65 %64 
					                                Private f32* %66 = OpAccessChain %28 %39 
					                                         f32 %67 = OpLoad %66 
					                                Private f32* %68 = OpAccessChain %28 %39 
					                                         f32 %69 = OpLoad %68 
					                                         f32 %70 = OpFMul %67 %69 
					                                Private f32* %71 = OpAccessChain %28 %39 
					                                                     OpStore %71 %70 
					                                Private f32* %73 = OpAccessChain %28 %39 
					                                         f32 %74 = OpLoad %73 
					                                         f32 %76 = OpFMul %74 %75 
					                                                     OpStore %72 %76 
					                                Private f32* %81 = OpAccessChain %28 %39 
					                                         f32 %82 = OpLoad %81 
					                                        bool %83 = OpFOrdGreaterThanEqual %80 %82 
					                                                     OpStore %79 %83 
					                                         f32 %85 = OpLoad %72 
					                                         f32 %86 = OpExtInst %1 13 %85 
					                                Private f32* %87 = OpAccessChain %84 %39 
					                                                     OpStore %87 %86 
					                                Private f32* %88 = OpAccessChain %84 %39 
					                                         f32 %89 = OpLoad %88 
					                                         f32 %90 = OpLoad %72 
					                                         f32 %91 = OpFDiv %89 %90 
					                                                     OpStore %72 %91 
					                                        bool %92 = OpLoad %79 
					                                                     OpSelectionMerge %96 None 
					                                                     OpBranchConditional %92 %95 %98 
					                                             %95 = OpLabel 
					                                                     OpStore %94 %97 
					                                                     OpBranch %96 
					                                             %98 = OpLabel 
					                                         f32 %99 = OpLoad %72 
					                                        f32 %100 = OpExtInst %1 4 %99 
					                                                     OpStore %94 %100 
					                                                     OpBranch %96 
					                                             %96 = OpLabel 
					                                        f32 %101 = OpLoad %94 
					                               Private f32* %102 = OpAccessChain %28 %39 
					                                                     OpStore %102 %101 
					                                      f32_2 %103 = OpLoad %9 
					                                      f32_2 %104 = OpFNegate %103 
					                                      f32_2 %107 = OpFAdd %104 %106 
					                                                     OpStore %84 %107 
					                                      f32_2 %108 = OpLoad %84 
					                                      f32_2 %109 = OpLoad %84 
					                                        f32 %110 = OpDot %108 %109 
					                                                     OpStore %72 %110 
					                                        f32 %111 = OpLoad %72 
					                                        f32 %112 = OpExtInst %1 31 %111 
					                                                     OpStore %72 %112 
					                                        f32 %113 = OpLoad %72 
					                               Uniform f32* %115 = OpAccessChain %16 %114 
					                                        f32 %116 = OpLoad %115 
					                                        f32 %117 = OpFNegate %116 
					                                        f32 %118 = OpFAdd %113 %117 
					                                                     OpStore %72 %118 
					                               Uniform f32* %119 = OpAccessChain %16 %114 
					                                        f32 %120 = OpLoad %119 
					                                        f32 %122 = OpFAdd %120 %121 
					                               Private f32* %123 = OpAccessChain %84 %39 
					                                                     OpStore %123 %122 
					                               Private f32* %124 = OpAccessChain %84 %39 
					                                        f32 %125 = OpLoad %124 
					                               Uniform f32* %127 = OpAccessChain %16 %126 
					                                        f32 %128 = OpLoad %127 
					                                        f32 %129 = OpFNegate %128 
					                                        f32 %130 = OpFAdd %125 %129 
					                               Private f32* %131 = OpAccessChain %84 %39 
					                                                     OpStore %131 %130 
					                               Private f32* %132 = OpAccessChain %84 %39 
					                                        f32 %133 = OpLoad %132 
					                               Uniform f32* %134 = OpAccessChain %16 %114 
					                                        f32 %135 = OpLoad %134 
					                                        f32 %136 = OpFNegate %135 
					                                        f32 %137 = OpFAdd %133 %136 
					                               Private f32* %138 = OpAccessChain %84 %39 
					                                                     OpStore %138 %137 
					                               Private f32* %139 = OpAccessChain %84 %39 
					                                        f32 %140 = OpLoad %139 
					                                        f32 %141 = OpFDiv %97 %140 
					                               Private f32* %142 = OpAccessChain %84 %39 
					                                                     OpStore %142 %141 
					                                        f32 %143 = OpLoad %72 
					                               Private f32* %144 = OpAccessChain %84 %39 
					                                        f32 %145 = OpLoad %144 
					                                        f32 %146 = OpFMul %143 %145 
					                                                     OpStore %72 %146 
					                                        f32 %147 = OpLoad %72 
					                                        f32 %149 = OpExtInst %1 43 %147 %148 %97 
					                                                     OpStore %72 %149 
					                                        f32 %150 = OpLoad %72 
					                                        f32 %152 = OpFMul %150 %151 
					                                        f32 %154 = OpFAdd %152 %153 
					                               Private f32* %155 = OpAccessChain %84 %39 
					                                                     OpStore %155 %154 
					                                        f32 %156 = OpLoad %72 
					                                        f32 %157 = OpLoad %72 
					                                        f32 %158 = OpFMul %156 %157 
					                                                     OpStore %72 %158 
					                               Private f32* %159 = OpAccessChain %84 %39 
					                                        f32 %160 = OpLoad %159 
					                                        f32 %161 = OpFNegate %160 
					                                        f32 %162 = OpLoad %72 
					                                        f32 %163 = OpFMul %161 %162 
					                                        f32 %164 = OpFAdd %163 %97 
					                                                     OpStore %72 %164 
					                               Private f32* %165 = OpAccessChain %28 %39 
					                                        f32 %166 = OpLoad %165 
					                                        f32 %167 = OpLoad %72 
					                                        f32 %168 = OpFMul %166 %167 
					                               Private f32* %169 = OpAccessChain %28 %39 
					                                                     OpStore %169 %168 
					                                      f32_2 %170 = OpLoad %28 
					                                      f32_2 %171 = OpVectorShuffle %170 %170 0 0 
					                                      f32_2 %172 = OpFNegate %171 
					                               Uniform f32* %174 = OpAccessChain %16 %173 
					                                        f32 %175 = OpLoad %174 
					                               Uniform f32* %176 = OpAccessChain %16 %173 
					                                        f32 %177 = OpLoad %176 
					                                      f32_2 %178 = OpCompositeConstruct %175 %177 
					                                        f32 %179 = OpCompositeExtract %178 0 
					                                        f32 %180 = OpCompositeExtract %178 1 
					                                      f32_2 %181 = OpCompositeConstruct %179 %180 
					                                      f32_2 %182 = OpFMul %172 %181 
					                                      f32_2 %183 = OpLoad %9 
					                                      f32_2 %184 = OpFAdd %182 %183 
					                                                     OpStore %9 %184 
					                        read_only Texture2D %191 = OpLoad %190 
					                                    sampler %195 = OpLoad %194 
					                 read_only Texture2DSampled %197 = OpSampledImage %191 %195 
					                                      f32_2 %198 = OpLoad %9 
					                                      f32_4 %199 = OpImageSampleImplicitLod %197 %198 
					                                      f32_3 %200 = OpVectorShuffle %199 %199 0 1 2 
					                                                     OpStore %187 %200 
					                                      f32_3 %203 = OpLoad %187 
					                                      f32_4 %204 = OpLoad %202 
					                                      f32_4 %205 = OpVectorShuffle %204 %203 4 5 6 3 
					                                                     OpStore %202 %205 
					                                Output f32* %208 = OpAccessChain %202 %206 
					                                                     OpStore %208 %97 
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
						float _TimeX;
						float _Value;
						float _Value2;
						float _Value3;
						vec4 unused_0_5;
						vec4 _MainTex_ST;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat10_0;
					vec2 u_xlat1;
					vec2 u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4.xy = u_xlat0.xy + vec2(-0.5, -0.5);
					    u_xlat4.x = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = (-_TimeX) * 0.333333343 + u_xlat4.x;
					    u_xlat4.x = u_xlat4.x * 5.0;
					    u_xlat4.x = sin(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * u_xlat4.x;
					    u_xlat6 = u_xlat4.x * 99.9999924;
					    u_xlatb4 = 0.00100000005>=u_xlat4.x;
					    u_xlat1.x = sin(u_xlat6);
					    u_xlat6 = u_xlat1.x / u_xlat6;
					    u_xlat4.x = (u_xlatb4) ? 1.0 : abs(u_xlat6);
					    u_xlat1.xy = (-u_xlat0.xy) + vec2(0.5, 0.5);
					    u_xlat6 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat6 = sqrt(u_xlat6);
					    u_xlat6 = u_xlat6 + (-_Value);
					    u_xlat1.x = _Value + -0.0500000007;
					    u_xlat1.x = u_xlat1.x + (-_Value2);
					    u_xlat1.x = u_xlat1.x + (-_Value);
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat6 = u_xlat6 * u_xlat1.x;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.x = u_xlat6 * -2.0 + 3.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = (-u_xlat1.x) * u_xlat6 + 1.0;
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat0.xy = (-u_xlat4.xx) * vec2(vec2(_Value3, _Value3)) + u_xlat0.xy;
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