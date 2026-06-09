project "Rage"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "off"

	targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "rapch.h"
	pchsource "src/rapch.cpp"

	files
	{
		"src/**.h",
		"src/**.cpp",
		"vendor/stb_image/**.h",
		"vendor/stb_image/**.cpp",
		"vendor/glm/glm/**.hpp",
		"vendor/glm/glm/**.inl",

		"vendor/ImGuizmo/ImGuizmo.h",
		"vendor/ImGuizmo/ImGuizmo.cpp"
	}

	defines
	{
		"_CRT_SECURE_NO_WARNINGS",
		"GLFW_INCLUDE_NONE"
	}

	includedirs
	{
		"src",
		"vendor/spdlog/include",
		"%{IncludeDir.Box2D}",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.glm}",
		"%{IncludeDir.stb_image}",
		"%{IncludeDir.entt}",
		"%{IncludeDir.yaml_cpp}",
		"%{IncludeDir.ImGuizmo}",
		"%{IncludeDir.VulkanSDK}"
	}
links
{
"Box2D",
"GLFW",
"Glad",
"ImGui",
"yaml-cpp",
"opengl32.lib",
"%{Library.ShaderC_Release}",
"%{Library.SPIRV_Cross_Release}",
"%{Library.SPIRV_Cross_GLSL_Release}"
}

filter "files:vendor/ImGuizmo/**.cpp"


	enablepch "Off"

	filter "system:windows"
		systemversion "latest"

		defines
		{
		}

	filter "configurations:Debug"
		defines
		{
			"RA_DEBUG",
			"_ITERATOR_DEBUG_LEVEL=0"
		}
		runtime "Release"
		symbols "on"

	filter "configurations:Release"
		defines "RA_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "RA_DIST"
		runtime "Release"
		optimize "on"
