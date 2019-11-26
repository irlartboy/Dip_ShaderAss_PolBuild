using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class Greyscale : MonoBehaviour
{
    public Shader curShader;
    public float greyscaleAmount = 1.0f;
    private Material screenMat;

    Material ScreenMat
    {
        get
        {
            if (screenMat == null)
            {
                screenMat = new Material(curShader);
                screenMat.hideFlags = HideFlags.HideAndDontSave;
            }
            return screenMat;
        }    
    }
    void Start()
    {
        if (!SystemInfo.supportsImageEffects)
        {
            enabled = false;
            return;
        }

        if (!curShader && !curShader.isSupported)
        {
            enabled = false;
        }
    }
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (curShader != null)
        {
            ScreenMat.SetFloat("_Luminosity", greyscaleAmount);
            Graphics.Blit(source, destination, ScreenMat);
        }
        else
        {
            Graphics.Blit(source, destination);
        }
    }
    void Update()
    {
        greyscaleAmount = Mathf.Clamp(greyscaleAmount, 0.0f, 1.0f);
    }
    private void OnDisable()
    {
        if (screenMat)
        {
            DestroyImmediate(screenMat);
        }
    }
}
