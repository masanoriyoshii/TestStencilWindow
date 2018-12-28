using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Move : MonoBehaviour {

    [SerializeField, Range(0.1f, 10f)]
    float _speed = 1f;

    [SerializeField, Range(0.1f, 20f)]
    float _ampX = 10f;

    [SerializeField, Range(0.1f, 20f)]
    float _ampZ = 5f;

    // Use this for initialization
    void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {

        float x = Mathf.Sin(Time.time * _speed) * _ampX;

        float z = Mathf.Sin(x / _ampX * Mathf.PI * 2f) * _ampZ;
        transform.localPosition = new Vector3(x, 0f, z);

	}
}
