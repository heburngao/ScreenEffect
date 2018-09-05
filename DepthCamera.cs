using System.Collections;
using System.Collections.Generic;
using UnityEngine;
// [ExecuteInEditMode]
public class DepthCamera : MonoBehaviour {
	public Material mat;
	// Use this for initialization
	void Start () {
		Camera.main.depthTextureMode = DepthTextureMode.Depth;
	}
	void OnRenderImage(RenderTexture src, RenderTexture des)
    {
        Graphics.Blit(src, des, mat);
    }
	// Update is called once per frame
	// void Update () {
		
	// }
}
